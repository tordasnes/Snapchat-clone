//
//  GravatarUrlBuilder.h
//  Ribbit
//
//  Copyright (c) 2013 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GravatarUrlBuilder : NSObject

+ (NSURL *)getGravatarUrl:(NSString *)email;

@end
