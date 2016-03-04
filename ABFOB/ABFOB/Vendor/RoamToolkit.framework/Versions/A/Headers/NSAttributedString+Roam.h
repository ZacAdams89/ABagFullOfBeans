//
//  NSAttributedString+Roam.h
//  RoamToolkit
//
//  Created by Stuart Austin on 24/04/15.
//  Copyright (c) 2015 Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Roam)

+ (instancetype)attributedStringWithString: (NSString *) string;
+ (instancetype)attributedStringWithString: (NSString *) string attributes: (NSDictionary *) attributes;

+ (instancetype)attributedStringWithFormat: (NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (instancetype)attributedStringWithAttributes: (NSDictionary *) attributes format: (NSString *)format, ... NS_FORMAT_FUNCTION(2,3);

- (NSAttributedString *)attributedStringByAppendingAttributedString: (NSAttributedString *) attributedString;

- (NSAttributedString *)attributedStringByAppendingString: (NSString *) string;
- (NSAttributedString *)attributedStringByAppendingString: (NSString *) string attributes: (NSDictionary *) attributes;

- (NSAttributedString *)attributedStringByAppendingFormat: (NSString *) format, ... NS_FORMAT_FUNCTION(1,2);
- (NSAttributedString *)attributedStringByAppendingFormatWithAttributes: (NSDictionary *) attributes format: (NSString *) format, ... NS_FORMAT_FUNCTION(2,3);

@end