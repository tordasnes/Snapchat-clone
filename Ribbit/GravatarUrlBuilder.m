//
//  GravatarUrlBuilder.m
//  Ribbit
//
//  Copyright (c) 2013 Treehouse. All rights reserved.
//

#import "GravatarUrlBuilder.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GravatarUrlBuilder

+ (NSURL *)getGravatarUrl:(NSString *)email {
    //  Copied from: https://github.com/ernstsson/GravatarIDObjC/blob/master/Impl/GravatarUIImageFactory.m
    email = [[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    const char *cStr = [email UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSString *hexValue = [[NSString stringWithFormat:
                          @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                          result[0], result[1], result[2], result[3],
                          result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11],
                          result[12], result[13], result[14], result[15]
                          ] lowercaseString];
    
    int squareSideLength = 32;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@.jpg?d=404&s=%d", hexValue, squareSideLength]];
    
    return url;
}

@end
