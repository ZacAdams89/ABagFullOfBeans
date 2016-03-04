//
//  LetManager.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LetManager : NSObject <Singleton>

- (void)cancelLet:(Let *)let;
- (void)checkoutLet:(Let *)let;
- (Let *)createLetWithQuantity:(NSInteger)quantity;

@end
