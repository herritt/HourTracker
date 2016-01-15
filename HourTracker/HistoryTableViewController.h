//
//  HistoryTableViewController.h
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-13.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HistoryTableViewController : UITableViewController <MFMailComposeViewControllerDelegate>

- (IBAction)emailReportAction:(UIBarButtonItem *)sender;

@end
