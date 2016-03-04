//
//  RoamCoreDataStore.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define DataStore               [CoreDataStore singleton]
#define DataContext             [DataStore context]
#define DataContextBackground   [DataStore backgroundContext]

@interface CoreDataStore : NSObject <Singleton>

@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectContext *backgroundContext;

- (void)clearAllData;

- (void)save;
- (void)saveContext:(NSManagedObjectContext *)context;

- (NSManagedObject *)createNewEntityForClass:(Class)entityClass context:(NSManagedObjectContext *)context;

- (void)removeEntity:(NSManagedObject *)entity context:(NSManagedObjectContext *)context;
- (void)removeAllEntitiesForClass:(Class)entityClass context:(NSManagedObjectContext *)context;

- (NSArray *)allForEntity:(Class)entityClass context:(NSManagedObjectContext *)context;
- (NSArray *)allForEntity:(Class)entityClass predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
- (NSArray *)allForEntity:(Class)entityClass predicate:(NSPredicate *)predicate orderBy:(NSString *)key ascending:(BOOL)ascending context:(NSManagedObjectContext *)context;
- (NSArray *)allForEntity:(Class)entityClass orderBy:(NSString *)key ascending:(BOOL)ascending context:(NSManagedObjectContext *)context;

- (NSManagedObject *)entityForClass:(Class)entityClass context:(NSManagedObjectContext *)context;
- (NSManagedObject *)entityForClass:(Class)entityClass predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;

- (NSManagedObject *)entityWithURI:(NSURL *)uri context:(NSManagedObjectContext *)context;
- (NSManagedObject *)entityWithObjectID:(NSManagedObjectID *)objectID context:(NSManagedObjectContext *)context;

- (NSInteger)countForEntity:(Class)entityClass context:(NSManagedObjectContext *)context;
- (NSInteger)countForEntity:(Class)entityClass predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;

@end
