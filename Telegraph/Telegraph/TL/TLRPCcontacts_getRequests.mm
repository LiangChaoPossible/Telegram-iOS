#import "TLRPCcontacts_getRequests.h"

#import "../NSInputStream+TL.h"
#import "../NSOutputStream+TL.h"

#import "TLcontacts_Requests.h"

@implementation TLRPCcontacts_getRequests

@synthesize offset = _offset;
@synthesize limit = _limit;

- (Class)responseClass
{
    return [TLcontacts_Requests class];
}

- (int)impliedResponseSignature
{
    return 0;
}

- (int)layerVersion
{
    return 8;
}

- (int32_t)TLconstructorSignature
{
    TGLog(@"constructorSignature is not implemented for base type");
    return 0;
}

- (int32_t)TLconstructorName
{
    TGLog(@"constructorName is not implemented for base type");
    return 0;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)__unused metaObject
{
    TGLog(@"TLbuildFromMetaObject is not implemented for base type");
    return nil;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)__unused values
{
    TGLog(@"TLfillFieldsWithValues is not implemented for base type");
}


@end

@implementation TLRPCcontacts_getRequests$contacts_getRequests : TLRPCcontacts_getRequests


- (int32_t)TLconstructorSignature
{
    return (int32_t)0xf10a772e;
}

- (int32_t)TLconstructorName
{
    return (int32_t)0xcb8473eb;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)metaObject
{
    TLRPCcontacts_getRequests$contacts_getRequests *object = [[TLRPCcontacts_getRequests$contacts_getRequests alloc] init];
    object.offset = metaObject->getInt32(0xfc56269);
    object.limit = metaObject->getInt32(0xb8433fca);
    return object;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)values
{
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveInt32;
        value.primitive.int32Value = self.offset;
        values->insert(std::pair<int32_t, TLConstructedValue>(0xfc56269, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveInt32;
        value.primitive.int32Value = self.limit;
        values->insert(std::pair<int32_t, TLConstructedValue>(0xb8433fca, value));
    }
}


@end

