//
//  utility.h
//  Cafe Lagarto
//
//  Created by iPHTech11 on 08/03/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface utility : NSObject

+(NSString *)deviseToken;
+(NSString *)getUUID;
+(void)generateUniqueUUIDandSaveInKeyChain;


@end
