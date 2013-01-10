//
//  CoreDataBase.h
//  CoreDataWithFB
//
//  Created by Duong Van Dinh on 1/5/13.
//  Copyright (c) 2013 Duong Van Dinh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataBase : NSObject {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
+ (CoreDataBase *) coreDataBase;
- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

//create new managedObject
- (NSManagedObject *) createObjectWithEntityName : (NSString *) entityName;
// For retrieval of objects
- (NSMutableArray *)getObjectsForEntity:(NSString*)entityName withSortKey:(NSString*)sortKey andSortAscending:(BOOL)sortAscending;
- (NSMutableArray *)searchObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate *)predicate andSortKey:(NSString*)sortKey andSortAscending:(BOOL)sortAscending ;

// For counting objects
- (NSUInteger)countForEntity:(NSString *)entityName;
- (NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate ;
// For deletion of objects
- (BOOL)deleteAllObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
- (BOOL)deleteAllObjectsForEntity:(NSString*)entityName;
@end
