//
//  HistoryTableViewController.m
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-13.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "SavedData.h"
#import "HourData.h"

@interface HistoryTableViewController () {
    NSArray *data;
}

@end

@implementation HistoryTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [SavedData getSavedData];
    
    data = [data sortedArrayUsingSelector:@selector(compare:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    HourData* hourData = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [self getMonthForReport:hourData];
    cell.detailTextLabel.text = hourData.hours;

    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString*)getMonthForReport:(HourData*)hourData {
    
    NSDateComponents *thisComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:hourData.date];
    
    NSString *month;
    switch ([thisComponent month]) {
        case 1:
            month = @"Jan";
            break;
        case 2:
            month = @"Feb";
            break;
        case 3:
            month = @"Mar";
            break;
        case 4:
            month = @"Apr";
            break;
        case 5:
            month = @"May";
            break;
        case 6:
            month = @"Jun";
            break;
        case 7:
            month = @"Jul";
            break;
        case 8:
            month = @"Aug";
            break;
        case 9:
            month = @"Sep";
            break;
        case 10:
            month = @"Oct";
            break;
        case 11:
            month = @"Nov";
            break;
        case 12:
            month = @"Dec";
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%ld %@ %ld", (long)[thisComponent day], month, [thisComponent year]];
    
}

-(NSString*)getMessageBody {
    
    NSString* messageBodyFull = [NSMutableString new];
    messageBodyFull = @"";
    
    for (HourData* hourData in data) {
        
        NSString *str = [NSString stringWithFormat:@"%@           %@\n", [self getMonthForReport:hourData], hourData.hours];
        
        NSUInteger len = [str length];
        unichar buffer[len+1];
        
        [str getCharacters:buffer range:NSMakeRange(0, len)];
        
        messageBodyFull = [messageBodyFull stringByAppendingString:str];
    }
    
    return messageBodyFull;
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if(error) NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
        [self dismissViewControllerAnimated:YES completion:nil];
    return;
}


- (IBAction)emailReportAction:(UIBarButtonItem *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Send Report?" message:@"Email report to xxx@xxx.com" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSString *emailTitle = @"Work Schedule";
                             // Email Content
                             NSString *messageBody = [self getMessageBody];

                             // To address
                             NSArray *toRecipents = [NSArray arrayWithObject:@"xxx@xxx.com"];
                             
                             MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                             mc.mailComposeDelegate = self;
                             [mc setSubject:emailTitle];
                             [mc setMessageBody:messageBody isHTML:NO];
                             [mc setToRecipients:toRecipents];
                             
                             // Present mail view controller on screen
                             [self presentViewController:mc animated:YES completion:nil];
                             
                             
                         }];
    
    UIAlertAction* cancel = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                         }];
    
    
    [alert addAction:cancel];
    [alert addAction:ok];
    
}
@end
