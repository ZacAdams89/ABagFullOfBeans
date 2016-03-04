//
//  LetDataSource.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LetDataSourceDelegate;

@interface LetDataSource : NSObject

- (instancetype)initWithQuery:(PFQuery *)query;
- (Let *)letAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)IndexpathForLet:(Let *)let;
- (void)refreshData;

@end



