//
//  ListFriendFBViewController.m
//  HelloFB
//
//  Created by Duong Van Dinh on 1/7/13.
//  Copyright (c) 2013 Duong Van Dinh. All rights reserved.
//

#import "ListFriendFBViewController.h"
@interface ListFriendFBViewController ()

@end

@implementation ListFriendFBViewController

@synthesize dataTable,tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!friendCD) {
        friendCD = [[FriendCD alloc] init];
    }
    self.dataTable =  [[NSMutableArray alloc] init];
    dataTable = [friendCD getAll];
    for (Friend *f in dataTable) {
        NSLog(@"id %@",[f fid]);
    }
    NSLog(@"count   %d", [dataTable count] );
    //dataTable = [NSArray arrayWithObjects:@"a",@"b", nil];
//    self.dataTable =  [[NSMutableArray alloc] init];
//    // create and add 10 data items to the table data array.
//    for (NSUInteger i = 0; i< 20; i++) {
//        //The cell will contain a string "Item x"
//        NSString *dataString = [NSString stringWithFormat:@"Item %d",i ];
//        // Here dataString will add tableData;
//        [self.dataTable addObject:dataString];
//        
//    }
    // Do any additional setup after loading the view from its nib.
}

//- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    //friendCD = [[FriendCD alloc] init];
//   // dataTable = [friendCD getAll];
//    NSLog(@"count in number %d", [dataTable count] );
//    if (self.dataTable != nil) {
//        return [self.dataTable count];
//    }
//    return 0;
//    
//}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// So luong dong cua bang se dc hien thi len trong 1 section;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataTable count];
}


- (UITableViewCell*) tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //Friend *friend = [self.dataTable objectAtIndex:indexPath.row];
    //if (friend) {
       // NSLog(@"[ name] %@",[friend fid]);
        //cell.textLabel.text = [[friend fid] stringValue];
        cell.textLabel.text = @"sds";
        //[friend release];
   // }else {
        //cell.textLabel.text = @"k co";
    //}
    //cell.textLabel.text = [self.dataTable objectAtIndex:indexPath.row];
    return  cell;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) dealloc {
    [dataTable release];
    [super dealloc];
}

@end
