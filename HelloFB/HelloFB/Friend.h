//
//  Friend.h
//  HelloFB
//
//  Created by Duong Van Dinh on 1/7/13.
//  Copyright (c) 2013 Duong Van Dinh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSNumber * fid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * username;

@end
