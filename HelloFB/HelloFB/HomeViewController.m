//
//  HomeViewController.m
//  HelloFB
//
//  Created by Duong Van Dinh on 12/18/12.
//  Copyright (c) 2012 Duong Van Dinh. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "FacebookSDK/FBRequest.h"
#import "Friend.h"
#import "ListFriendFBViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (IBAction)listFriendsDB:(id)sender {
    NSMutableArray *allData = [friendCD getAll];
    if (allData) {
        for (Friend *f in allData) {
            NSLog(@"id:  %@ - name: %@  - username: %@",[f fid],[f name], [f username]);
        }
    }
    //ListFriendFBViewController *listController = [[ListFriendFBViewController alloc] initWithNibName:@"ListFriendFBViewController" bundle:nil];
   // [self.navigationController pushViewController:listController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!friendCD) {
        friendCD = [[FriendCD alloc] init];
    }
    // Create Login View so that the app will be granted "status_update" permission.
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame, 5, 5);
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    self.buttonPostPhoto.enabled = YES;
    self.buttonPostStatus.enabled = YES;
    self.buttonPickFriends.enabled = YES;
    self.buttonPickPlace.enabled = YES;
    self.buttonGetAllFriendsFB.enabled = YES;
    self.buttonCreateAlbum.enabled = YES;
    self.buttonUpdateImageAndStatus.enabled = YES;
    self.buttonSyncFriendsFB.enabled = YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.id;
   // NSLog(@"Description %@",[user description]);
   // NSLog(@"middle_name %@",[user middle_name]);
   // NSLog(@"name %@",[user name]);
    //NSLog(@"username %@",[user username]);
    self.loggedInUser = user;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    BOOL canShareAnyhow = [FBNativeDialogs canPresentShareDialogWithSession:nil];
    self.buttonPostStatus.enabled = canShareAnyhow;
    self.buttonPostPhoto.enabled = NO;
    self.buttonPickFriends.enabled = NO;
    self.buttonPickPlace.enabled = NO;
    self.buttonGetAllFriendsFB.enabled = NO;
    self.buttonCreateAlbum.enabled = NO;
    self.buttonUpdateImageAndStatus.enabled = NO;
    self.buttonSyncFriendsFB.enabled = NO;
    
    self.profilePic.profileID = nil;
    self.labelFirstName.text = nil;
    self.loggedInUser = nil;
}

#pragma mark -

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession reauthorizeWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                                   defaultAudience:FBSessionDefaultAudienceFriends
                                                 completionHandler:^(FBSession *session, NSError *error) {
                                                     if (!error) {
                                                         action();
                                                     }
                                                     //For this example, ignore errors (such as if user cancels).
                                                 }];
    } else {
        action();
    }
    
}

// Post Status Update button handler; will attempt to invoke the native
// share dialog and, if that's unavailable, will post directly
- (IBAction)postStatusUpdateClick:(UIButton *)sender {
    // Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
    //NSString *name = self.loggedInUser.first_name;
    NSString *message = [NSString stringWithFormat:@"Post from IPhone"];
    
    // if it is available to us, we will post using the native dialog
    BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
                                                                    initialText:nil
                                                                          image:nil
                                                                            url:nil
                                                                        handler:nil];
    if (!displayedNativeDialog) {
        
        [self performPublishAction:^{
            // otherwise fall back on a request for permissions and a direct post
            [FBRequestConnection startForPostStatusUpdate:message
                                        completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                            
                                            [self showAlert:message result:result error:error];
                                            self.buttonPostStatus.enabled = YES;
                                        }];
            
            self.buttonPostStatus.enabled = NO;
        }];
       
    }
}

/*!
 *** tao album anh tren facebook
 */
-(IBAction)createAlbum:(id)sender {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSString *message = [NSString stringWithFormat:@"Post from IPhone"];
    NSString *description = [NSString stringWithFormat:@"my love"];
    UIImage *img = [UIImage imageNamed:@"flower.jpg"];
    [dictionary setObject:message forKey:@"message"];
    [dictionary setObject:img forKey:@"picture"];
    [dictionary setObject:description forKey:@"description"];
    [dictionary setObject:@"https://developers.facebook.com/ios" forKey:@"link"];
    [dictionary setObject:@"Post from IPhone" forKey:@"caption"];
    // if it is available to us, we will post using the native dialog
    BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
                                                                    initialText:nil
                                                                          image:nil
                                                                            url:nil
                                                                        handler:nil];
    if (!displayedNativeDialog) {
        [self performPublishAction:^{
            // otherwise fall back on a request for permissions and a direct post
            [FBRequestConnection startWithGraphPath:@"me/photos"
                                         parameters:dictionary
                                         HTTPMethod:@"POST"
                                         completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                            
                                            [self showAlert:message result:result error:error];
                                            self.buttonCreateAlbum.enabled = YES;
                                             [dictionary release];
                                        }];            

            self.buttonCreateAlbum.enabled = NO;
        }];
    }

}

-(IBAction)updateImageAndStatus:(id)sender {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSString *message = [NSString stringWithFormat:@"Viết Tình Ca"];
    NSString *description = [NSString stringWithFormat:@"my love"];
    //UIImage *img = [UIImage imageNamed:@"flower.jpg"];
    [dictionary setObject:message forKey:@"message"];
    //[dictionary setObject:img forKey:@"picture"];
    [dictionary setObject:description forKey:@"description"];
    [dictionary setObject:@"http://mp3.zing.vn/bai-hat/Viet-Tinh-Ca-Ta-Quang-Tha-ng/ZWZFFU9A.html"
                   forKey:@"link"];
    [dictionary setObject:@"Viết Tình Ca - Tạ Quang Thắng | 320 lyrics" forKey:@"caption"];
    // if it is available to us, we will post using the native dialog
    BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
                                                                    initialText:nil
                                                                          image:nil
                                                                            url:nil
                                                                        handler:nil];
    if (!displayedNativeDialog) {
        [self performPublishAction:^{
            // otherwise fall back on a request for permissions and a direct post
            [FBRequestConnection startWithGraphPath:@"me/feed"
                                         parameters:dictionary
                                         HTTPMethod:@"POST"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      
                                      [self showAlert:message result:result error:error];
                                      self.buttonUpdateImageAndStatus.enabled = YES;
                                      [dictionary release];
                                  }];

            self.buttonUpdateImageAndStatus.enabled = NO;
        }];
    }
}

// Post Photo button handler; will attempt to invoke the native
 //share dialog and, if that's unavailable, will post directly
- (IBAction)postPhotoClick:(UIButton *)sender {
    // Just use the icon image from the application itself.  A real app would have a more
    // useful way to get an image.
    UIImage *img = [UIImage imageNamed:@"sd.gif"];
    
    // if it is available to us, we will post using the native dialog
    BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
                                                                    initialText:nil
                                                                          image:img
                                                                            url:nil
                                                                        handler:nil];
    if (!displayedNativeDialog) {
        [self performPublishAction:^{
            
            [FBRequestConnection startForUploadPhoto:img
                                   completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                       [self showAlert:@"Photo Post" result:result error:error];
                                       self.buttonPostPhoto.enabled = YES;
                                   }];
            
            self.buttonPostPhoto.enabled = NO;
        }];
    }
}

-(IBAction) getAllFriendsFB:(UIButton *)sender {
    __block NSArray *data = nil;
    [self performPublishAction:^{
        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            //NSLog(@"Friends %@",result);
            NSArray* friends = [result objectForKey:@"data"];
            data = friends;
            NSLog(@"Found: %i friends", friends.count);
           // NSMutableDictionary  *postVariablesDictionary = [[NSMutableDictionary alloc] init];
            //[postVariablesDictionary setObject:@"LOL" forKey:@"name"];
            //[postVariablesDictionary setObject:@"message" forKey:@"message"];
            NSString *message = [NSString stringWithFormat:@"Post from IPhone"];
            [FBRequestConnection startForPostStatusUpdate:message place:nil tags:friends completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                NSLog(@"TTTTTTTTT");
               // [self showAlert:@"Photo Post" result:result error:error];
               // self.buttonGetAllFriendsFB.enabled = YES;
            }];
            for (NSDictionary<FBGraphUser>* friend in friends) {
                
                NSLog(@"I have a friend named %@ with id %@ username %@ ", friend.name, friend.id, friend.username);
                
            }
            
            //[postVariablesDictionary release];
          //  self.buttonGetAllFriendsFB.enabled = YES;
        }];
       // self.buttonGetAllFriendsFB.enabled = NO;
    }];
}

- (IBAction) syncFriendsFB:(UIButton *)sender {
    
    //__block NSArray *data = nil;
    [self performPublishAction:^{
        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            //NSLog(@"Friends %@",result);
            NSArray* friends = [result objectForKey:@"data"];
           // data = friends;
            NSLog(@"friends %@",friends);
            BOOL status = [friendCD deleteAll];
            if (status) {
                NSLog(@"delete ok" );
            }
            NSUInteger countFriendsFromDB = [friendCD count];
            NSUInteger countFriendsFromFB =  [friends count];
            NSLog(@"countFriendsFromDB %d",countFriendsFromDB);
            if (status && countFriendsFromDB < countFriendsFromFB) {
                //  NSMutableArray *allFriends =  [FBHelper getAllFriends];
                if (friends) {
                    for (NSDictionary<FBGraphUser>* friend in friends) {
                        NSArray *array1 = nil;
                        NSDictionary *dict = nil;
                        if (friend.username) {
                            array1 = [NSArray arrayWithObjects:friend.id,friend.name,friend.username ,nil];
                            dict = [NSDictionary dictionaryWithObjects:array1 forKeys:[NSArray arrayWithObjects:@"fid",@"name", @"username", nil]];                            
                        }else {
                            array1 = [NSArray arrayWithObjects:friend.id,friend.name ,nil];
                            dict = [NSDictionary dictionaryWithObjects:array1 forKeys:[NSArray arrayWithObjects:@"fid",@"name", nil]];
                        }
                        [friendCD create:dict];
                       // [array1 release];
                        
                        //[dict release];
                       // NSLog(@"I have a friend named %@ with id %@ username %@ ", friend.name, friend.id, friend.username);
                        
                    }
                }
            }else {
                NSLog(@"ko insert nua");
            }
            //[postVariablesDictionary release];
             // self.buttonSyncFriendsFB.enabled = YES;
        }];
        // self.buttonSyncFriendsFB.enabled = NO;
    }];

}


// Pick Friends button handler
- (IBAction)pickFriendsClick:(UIButton *)sender {
    FBFriendPickerViewController *friendPickerController = [[FBFriendPickerViewController alloc] init];
    friendPickerController.title = @"Pick Friends";
    [friendPickerController loadData];
    
    // Use the modal wrapper method to display the picker.
    [friendPickerController presentModallyFromViewController:self animated:YES handler:
     ^(FBViewController *sender, BOOL donePressed) {
         if (!donePressed) {
             return;
         }
         NSString *message;
         
         if (friendPickerController.selection.count == 0) {
             message = @"<No Friends Selected>";
         } else {
             
             NSMutableString *text = [[NSMutableString alloc] init];
             
             // we pick up the users from the selection, and create a string that we use to update the text view
             // at the bottom of the display; note that self.selection is a property inherited from our base class
             for (id<FBGraphUser> user in friendPickerController.selection) {
                 if ([text length]) {
                     [text appendString:@", "];
                 }
                 [text appendString:user.name];
                 NSLog(@"description %@",[user description]);
             }
             message = text;
             
         }
         
         [[[UIAlertView alloc] initWithTitle:@"You Picked:"
                                     message:message
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil]
          show];
     }];
}

// Pick Place button handler
- (IBAction)pickPlaceClick:(UIButton *)sender {
    FBPlacePickerViewController *placePickerController = [[FBPlacePickerViewController alloc] init];
    placePickerController.title = @"Pick ";
    placePickerController.locationCoordinate = CLLocationCoordinate2DMake(47.6097, -122.3331);
    [placePickerController loadData];

    // Use the modal wrapper method to display the picker.
    [placePickerController presentModallyFromViewController:self animated:YES handler:
     ^(FBViewController *sender, BOOL donePressed) {
         if (!donePressed) {
             return;
         }
         
         NSString *placeName = placePickerController.selection.name;
         if (!placeName) {
             placeName = @"<No Place Selected>";
         }
         
         [[[UIAlertView alloc] initWithTitle:@"You Picked:"
                                     message:placeName
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil]
          show];
     }];
}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle = @"Error";
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.\nPost ID: %@",
                    message, [resultDict valueForKey:@"id"]];
        alertTitle = @"Success";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void) dealloc {
    [friendCD release];
    [super dealloc];
}


- (void)viewDidUnload {
    self.buttonPickFriends = nil;
    self.buttonPickPlace = nil;
    self.buttonPostPhoto = nil;
    self.buttonPostStatus = nil;
    self.labelFirstName = nil;
    self.loggedInUser = nil;
    self.profilePic = nil;
    self.buttonGetAllFriendsFB = nil;
    self.buttonCreateAlbum = nil;
    self.buttonUpdateImageAndStatus = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
