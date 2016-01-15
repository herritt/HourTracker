//
//  RecordHoursViewController.m
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-09.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import "RecordHoursViewController.h"
#import "SavedData.h"
#import "HourData.h"

@interface RecordHoursViewController () {
}

@end

@implementation RecordHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view endEditing:YES];
    
    [self.hoursTextField becomeFirstResponder];
    
}

- (IBAction)touchedDoneButton:(id)sender {

    HourData* data = [[HourData alloc] initWithDate:_datePicker.date andHours:_hoursTextField.text];
    
    [SavedData updateData:data];
    
    [self.hoursTextField endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
