//
//  DataSource.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceDelegate;

@interface DataSource : NSObject

@end


@protocol DataSourceDelegate <NSObject>

@required
- (void)dataSource:(DataSource *)dataSource objectWasInserted:(PFObject *)object;
- (void)dataSource:(DataSource *)dataSource objectWasRemoved:(PFObject *)object;

@end
