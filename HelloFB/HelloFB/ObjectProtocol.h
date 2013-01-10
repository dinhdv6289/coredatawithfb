//
//  CDBase.h
//  HelloFB
//
//  Created by Duong Van Dinh on 1/9/13.
//  Copyright (c) 2013 Duong Van Dinh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectProtocol <NSObject>
- (void) create : (NSDictionary *) newObject;
- (NSMutableArray *)getAll;
- (NSUInteger) count;
- (BOOL) deleteAll;

@optional
- (int)status;
@end
