#import "TGConversationCreateChatRequestActor.h"

#import "ActionStage.h"
#import "SGraphObjectNode.h"

#import "TGTelegraph.h"
#import "TGSchema.h"

#import "TGUserDataRequestBuilder.h"
#import "TGMessage+Telegraph.h"
#import "TGConversation+Telegraph.h"

#import "TGConversationAddMessagesActor.h"

#import "TGSession.h"

@interface TGConversationCreateChatRequestActor ()

@property (nonatomic, strong) NSArray *uids;

@end

@implementation TGConversationCreateChatRequestActor

+ (NSString *)genericPath
{
    return @"/tg/conversation/createChat/@";
}

- (void)execute:(NSDictionary *)options
{
    _uids = [options objectForKey:@"uids"];
    NSString *title = [options objectForKey:@"title"];
    if (_uids == nil || title == nil)
    {
        [ActionStageInstance() actionFailed:self.path reason:-1];
        return;
    }
    
    self.cancelToken = [TGTelegraphInstance doCreateChat:_uids title:title actor:self];
}

- (void)createChatSuccess:(TLmessages_StatedMessage *)statedMessage
{
    [TGUserDataRequestBuilder executeUserDataUpdate:statedMessage.users];
    
    TGConversation *chatConversation = nil;
    
    if (statedMessage.chats.count != 0)
    {
        NSMutableDictionary *chats = [[NSMutableDictionary alloc] init];
        
        TGMessage *message = [[TGMessage alloc] initWithTelegraphMessageDesc:statedMessage.message];
        
        for (TLChat *chatDesc in statedMessage.chats)
        {
            TGConversation *conversation = [[TGConversation alloc] initWithTelegraphChatDesc:chatDesc];
            if (conversation != nil)
            {
                if (chatConversation == nil)
                {
                    chatConversation = conversation;
                    
                    chatConversation.chatParticipants = [[TGConversationParticipantsData alloc] init];
                    chatConversation.chatParticipants.version = chatConversation.chatVersion;
                    chatConversation.chatParticipants.chatAdminId = TGTelegraphInstance.clientUserId;
                    
                    NSMutableArray *newUids = [[NSMutableArray alloc] init];
                    NSMutableDictionary *newInvitedBy = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *newInvitedDates = [[NSMutableDictionary alloc] init];
                    
                    for (NSNumber *nUid in _uids)
                    {
                        [newUids addObject:nUid];
                        [newInvitedBy setObject:@(TGTelegraphInstance.clientUserId) forKey:nUid];
                        [newInvitedDates setObject:@((int)message.date) forKey:nUid];
                    }
                    
                    chatConversation.chatParticipants.chatParticipantUids = newUids;
                    chatConversation.chatParticipants.chatInvitedBy = newInvitedBy;
                    chatConversation.chatParticipants.chatInvitedDates = newInvitedDates;
                    
                    conversation = chatConversation;
                }
                
                [chats setObject:conversation forKey:[[NSNumber alloc] initWithLongLong:conversation.conversationId]];
            }
        }
        
        static int actionId = 0;
        [[[TGConversationAddMessagesActor alloc] initWithPath:[[NSString alloc] initWithFormat:@"/tg/addmessage/(addMember%d)", actionId++]] execute:[[NSDictionary alloc] initWithObjectsAndKeys:chats, @"chats", @[message], @"messages", nil]];
    }
    
    [[TGSession instance] updatePts:statedMessage.pts date:0 seq:statedMessage.seq];
    
    static int actionId = 0;
    [[[TGConversationAddMessagesActor alloc] initWithPath:[[NSString alloc] initWithFormat:@"/tg/addmessage/(createChat%d)", actionId++]] execute:[[NSDictionary alloc] initWithObjectsAndKeys:[[NSArray alloc] initWithObjects:chatConversation, nil], @"chats", nil]];
    
    [ActionStageInstance() actionCompleted:self.path result:[[SGraphObjectNode alloc] initWithObject:chatConversation]];
}

- (void)createChatFailed
{
    [ActionStageInstance() actionFailed:self.path reason:-1];
}

@end
