//
//  utility.m
//  Cafe Lagarto
//
//  Created by iPHTech11 on 08/03/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import "utility.h"

@implementation utility
+(NSString *)deviseToken
{
    NSString *url_Str = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviseToken"];
    if(url_Str)
        return url_Str;
    else
        return @"";
}

+(NSString *)getUUID
{
    NSString *url_Str = [[NSUserDefaults standardUserDefaults] stringForKey:@"SPUUID"];
    if(url_Str)
        return url_Str;
    else
        return @"";
}


+(void)generateUniqueUUIDandSaveInKeyChain
{
//PLEASE USE BELLOW COMMENTED CODE FOR GENERATE kKeyChainVendorIDAccessGroup == start

                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                                       (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
                                       @"bundleSeedID", kSecAttrAccount,
                                       @"", kSecAttrService,
                                       (id)kCFBooleanTrue, kSecReturnAttributes,
                                       nil];
                CFDictionaryRef result = nil;
                OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
                if (status == errSecItemNotFound)
                    status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
                if (status != errSecSuccess)
                    return ;
                NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
                NSArray *components = [accessGroup componentsSeparatedByString:@"."];
                NSString *bundleSeedID = [[components objectEnumerator] nextObject];

    //        //PLEASE USE BELLOW COMMENTED CODE FOR GENERATE kKeyChainVendorIDAccessGroup  == End
    
    
    static NSString * const kKeyChainVendorID = @"com.CafeLagarto";
    static NSString * const kKeyChainVendorIDAccessGroup = @"5SVLUC77QK.com.CafeLagarto";
    
    // First, check NSUserDefaults so that we're not hitting the KeyChain every single time
    NSString *uuidString = [[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"];
    BOOL vendorIDMissingFromUserDefaults = (uuidString == nil || uuidString.length == 0);
    
    if (vendorIDMissingFromUserDefaults) {
        // Check to see if a UUID is stored in the KeyChain
        NSDictionary *query = @{
                                (__bridge id)kSecClass:             (__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecAttrAccount:       kKeyChainVendorID,
                                (__bridge id)kSecAttrService:       kKeyChainVendorID,
                                (__bridge id)kSecAttrAccessGroup:   kKeyChainVendorIDAccessGroup,
                                (__bridge id)kSecMatchLimit:        (__bridge id)kSecMatchLimitOne,
                                (__bridge id)kSecReturnAttributes:  (__bridge id)kCFBooleanTrue
                                };
        CFTypeRef attributesRef = NULL;
        OSStatus result = SecItemCopyMatching((__bridge CFDictionaryRef)query, &attributesRef);
        if (result == noErr) {
            // There is a UUID, so try to retrieve it
            NSDictionary *attributes = (__bridge_transfer NSDictionary *)attributesRef;
            NSMutableDictionary *valueQuery = [NSMutableDictionary dictionaryWithDictionary:attributes];
            
            [valueQuery setObject:(__bridge id)kSecClassGenericPassword  forKey:(__bridge id)kSecClass];
            [valueQuery setObject:(__bridge id)kCFBooleanTrue            forKey:(__bridge id)kSecReturnData];
            
            CFTypeRef passwordDataRef = NULL;
            OSStatus result = SecItemCopyMatching((__bridge CFDictionaryRef)valueQuery, &passwordDataRef);
            if (result == noErr) {
                NSData *passwordData = (__bridge_transfer NSData *)passwordDataRef;
                uuidString = [[NSString alloc] initWithBytes:[passwordData bytes]
                                                      length:[passwordData length]
                                                    encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    // Failed to read the UUID from the KeyChain, so create a new UUID and store it
    if (uuidString == nil || uuidString.length == 0) {
        // Generate the new UIID
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
        CFRelease(uuidRef);
        
        // Now store it in the KeyChain
        NSDictionary *query = @{    (__bridge id)kSecClass:             (__bridge id)kSecClassGenericPassword,
                                    (__bridge id)kSecAttrAccount:       kKeyChainVendorID,
                                    (__bridge id)kSecAttrService:       kKeyChainVendorID,
                                    (__bridge id)kSecAttrAccessGroup:   kKeyChainVendorIDAccessGroup,
                                    (__bridge id)kSecAttrLabel:         @"",
                                    (__bridge id)kSecAttrDescription:   @"",
                                    (__bridge id)kSecAttrAccessible:    (__bridge id)kSecAttrAccessibleAfterFirstUnlock,
                                    (__bridge id)kSecValueData:         [uuidString dataUsingEncoding:NSUTF8StringEncoding]
                                    };
        
        OSStatus result = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
        if (result != noErr) {
            NSLog(@"ERROR: Couldn't add to the Keychain. Result = %ld; Query = %@", result, query);
            return;
        }
    }
    
    // Save UUID to NSUserDefaults so that we can avoid the KeyChain next time
    if (vendorIDMissingFromUserDefaults) {
        [[NSUserDefaults standardUserDefaults] setObject:uuidString forKey:@"UUID"];
    }
    
   //  return [[NSUUID alloc] initWithUUIDString:uuidString];
    
   }






@end
