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

-(NSMutableArray *) getAll {
    CoreDataBase *coreDataBase = [CoreDataBase coreDataBase];
    NSMutableArray *all = [coreDataBase getObjectsForEntity:kFriend withSortKey:@"name" andSortAscending:NO ];
    return all;
}

- (NSUInteger) count {
    return [[CoreDataBase coreDataBase] countForEntity:kFriend];
}

- (BOOL) deleteAll {
    return [[CoreDataBase coreDataBase] deleteAllObjectsForEntity:kFriend];
}


@end
