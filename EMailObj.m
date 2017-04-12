//
//  EMailObj.m
//  miniAccountant
//
//  Created by  on 11/10/27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EMailObj.h"

@implementation EMailObj
- (id)init{
    //[super init];
    contentText=@"";
    mainRecipients=@"";
    
    
    
    
    
    
    
    ///
    
    ///
    return self;
    
    
    
}
-(void)createNewEmail:(UIViewController *)target subtitle:(NSString *)_subtitle contentText:(NSString *)_contentText mainRecipients:(NSString *)_mainRecipients filepathArray:(NSArray *)_filepatharray{
    subtitle=_subtitle;
    filepatharray=_filepatharray;
    mainRecipients=_mainRecipients;
    tagView=target;
    contentText=_contentText;
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    if (mailClass != nil)  
    {  
        if ([mailClass canSendMail])  
        {  
            [self Email_displayComposerSheet];  
        }   
        else   
        {  
            [self Email_launchMailAppOnDevice];  
        }  
    }   
    else   
    {  
        [self Email_launchMailAppOnDevice];  
    }
}
//可以发送邮件的话  
-(void)Email_displayComposerSheet{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    mailPicker.mailComposeDelegate = self;  
	
    //设置主题  
    [mailPicker setSubject: subtitle];  
	
    // 添加发送者  
    NSArray *toRecipients = [NSArray arrayWithObject:mainRecipients ];
                             //@"maplepagemax@gmail.com"];  
    [mailPicker setToRecipients: toRecipients];  
    // 添加图片  
    //UIImage *addPic = [UIImage imageNamed: @"123.jpg"];  
    //NSData *imageData = UIImagePNGRepresentation(addPic);  // png  
    // NSData *imageData = UIImageJPEGRepresentation(addPic, 1);    // jpeg 
    for (int i=0; i<[filepatharray count]; i++) {
        //NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"my.db"];
        NSData *a=[[NSData alloc] initWithContentsOfFile:[filepatharray objectAtIndex:i]];
        NSString *filename=[[[filepatharray objectAtIndex:i] componentsSeparatedByString:@"/"] lastObject];
        //NSString *filename;//=[[filepatharray objectAtIndex:i] ]
        //[[filename componentsSeparatedByString:@"/"] objectAtIndex:<#(NSUInteger)#>]
        [mailPicker addAttachmentData:a mimeType:@"" fileName:filename];
        //[mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"123.jpg"];  
    }
    //[mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"123.jpg"];  
	
    NSString *emailBody = contentText;
    //@"<font color='black'>Welcome any suggestions to me</font><BR/><font style='color:#990088'></font>";  
    [mailPicker setMessageBody:emailBody isHTML:YES];  
	[tagView presentModalViewController:mailPicker animated:YES];
    //[mailPicker release];  
}  
-(void)Email_launchMailAppOnDevice  
{  
    NSString *recipients = @"";//@"mailto:mixertower@gmail.com&subject=my email!";  
    NSString *body = @"&body=email body!";  
	
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];  
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  
	
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];  
}  
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error   
{
    NSString *msg;
    switch (result)   
    {  
        case MFMailComposeResultCancelled:  
            msg = @"E-Mail cancel.";  
            break;  
        case MFMailComposeResultSaved:  
            msg = @"E-Mail saved.";  
            break;  
        case MFMailComposeResultSent:  
            msg = @"E-Mail completed";  
            break;  
        case MFMailComposeResultFailed:  
            msg = @"E-Mail fail.";  
            break;  
        default:  
            break;  
    }
    UIAlertView *yy=[[UIAlertView alloc] initWithTitle:@"E-Mail" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [yy show];
    //[yy release];
    [tagView dismissModalViewControllerAnimated:YES];
}  


@end
