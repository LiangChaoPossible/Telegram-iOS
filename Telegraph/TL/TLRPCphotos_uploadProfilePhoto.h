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

@class TLInputFile;
@class TLInputGeoPoint;
@class TLInputPhotoCrop;
@class TLphotos_Photo;

@interface TLRPCphotos_uploadProfilePhoto : TLMetaRpc

@property (nonatomic, retain) TLInputFile *file;
@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) TLInputGeoPoint *geo_point;
@property (nonatomic, retain) TLInputPhotoCrop *crop;

- (Class)responseClass;

- (int)impliedResponseSignature;

@end

@interface TLRPCphotos_uploadProfilePhoto$photos_uploadProfilePhoto : TLRPCphotos_uploadProfilePhoto


@end

