//
//  LetDataSource.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LetDataSource.h"

@interface LetDataSource ()

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSArray *lets;

@end

@implementation LetDataSource

- (instancetype)initWithQuery:(PFQuery *)query{
    self = [super init];
    
    if(self){
        
    }
    return self;
}


//- (Let *)letAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//- (NSIndexPath *)IndexpathForLet:(Let *)let{
//    
//}

- (void)refreshData{
    
}

@end
