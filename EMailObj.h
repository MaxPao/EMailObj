//
//  EMailObj.h
//  miniAccountant
//
//  Created by  on 11/10/27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface EMailObj : NSObject<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>{
    UIViewController *tagView;
    NSString *contentText;
    NSString *mainRecipients;
    NSArray *filepatharray;
    NSString *subtitle;
    MFMailComposeViewController *mailPicker;
}
- (id)init;
-(void)createNewEmail:(UIViewController *)target subtitle:(NSString *)_subtitle contentText:(NSString *)_contentText mainRecipients:(NSString *)_mainRecipients filepathArray:(NSArray *)_filepatharray;
-(void)Email_displayComposerSheet;
-(void)Email_launchMailAppOnDevice  ;  
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
@end
