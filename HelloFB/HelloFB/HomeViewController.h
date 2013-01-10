//
//  HomeViewController.h
//  HelloFB
//
//  Created by Duong Van Dinh on 12/18/12.
//  Copyright (c) 2012 Duong Van Dinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FriendCD.h"
@interface HomeViewController : UIViewController <FBLoginViewDelegate>  {
    FriendCD *friendCD;
}
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UIButton *buttonPostStatus;
@property (strong, nonatomic) IBOutlet UIButton *buttonPostPhoto;
@property (strong, nonatomic) IBOutlet UIButton *buttonPickFriends;
@property (strong, nonatomic) IBOutlet UIButton *buttonPickPlace;
@property (strong, nonatomic) IBOutlet UIButton *buttonCreateAlbum;
@property (strong, nonatomic) IBOutlet UIButton *buttonUpdateImageAndStatus;
@property (strong, nonatomic) IBOutlet UIButton *buttonGetAllFriendsFB;
@property (strong, nonatomic) IBOutlet UIButton *buttonSyncFriendsFB;
@property (strong, nonatomic) IBOutlet UILabel *labelFirstName;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

- (IBAction)postStatusUpdateClick:(UIButton *)sender;
- (IBAction)postPhotoClick:(UIButton *)sender;
- (IBAction)pickFriendsClick:(UIButton *)sender;
- (IBAction)pickPlaceClick:(UIButton *)sender;
- (IBAction)createAlbum:(id)sender;
- (IBAction)updateImageAndStatus:(id)sender;
- (IBAction) getAllFriendsFB:(UIButton *)sender;
- (IBAction) syncFriendsFB:(UIButton *)sender;
- (IBAction)listFriendsDB:(id)sender;
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error;
@end
