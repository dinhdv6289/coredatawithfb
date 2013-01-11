//
//  FriendCD.m
//  CoreDataWithFB
//
//  Created by Duong Van Dinh on 1/5/13.
//  Copyright (c) 2013 Duong Van Dinh. All rights reserved.
//

#import "FriendCD.h"

#define kFriend @"Friend"

@implementation FriendCD

/**
 * methodName  create
 * parameter - NSDictionary newFriend
 * returns - void
 */
- (void) create :(NSDictionary *) newFriend{
    CoreDataBase *coreDataBase = [CoreDataBase coreDataBase];
    Friend *friend = (Friend*)[coreDataBase createObjectWithEntityName:kFriend];
    NSNumber *fid = [NSNumber numberWithInt:[[newFriend objectForKey:@"fid"] intValue] ];
    NSString *name = [newFriend objectForKey:@"name"];
    NSString *username = [newFriend objectForKey:@"username"];
    [friend setFid:fid];
    [friend setName:name];
    [friend setUsername:username];
    [coreDataBase saveContext];
    NSLog(@"Save success");
}

/*
 * methodName  getAll
 * parameter - 
 * returns - NSMutableArray
 */
-(NSMutableArray *) getAll {
    CoreDataBase *coreDataBase = [CoreDataBase coreDataBase];
    NSMutableArray *all = [coreDataBase getObjectsForEntity:kFriend withSortKey:@"name" andSortAscending:NO ];
    return all;
}

/**
 * methodName  count
 * parameter -
 * returns - NSUInteger
 */
- (NSUInteger) count {
    return [[CoreDataBase coreDataBase] countForEntity:kFriend];
}

/**
 * methodName  deleteAll
 * parameter -
 * returns - BOOL
 */
- (BOOL) deleteAll {
    return [[CoreDataBase coreDataBase] deleteAllObjectsForEntity:kFriend];
}


@end
