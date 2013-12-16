/*
 * This is the source code of Telegram for iOS v. 1.1
 * It is licensed under GNU GPL v. 2 or later.
 * You should have received a copy of the license in this archive (see LICENSE).
 *
 * Copyright Peter Iakovlev, 2013.
 */

#import <Foundation/Foundation.h>

#import "TLObject.h"
#import "TLMetaRpc.h"


@interface TLContact : NSObject <TLObject>

@property (nonatomic) int32_t user_id;
@property (nonatomic) bool mutual;

@end

@interface TLContact$contact : TLContact


@end

