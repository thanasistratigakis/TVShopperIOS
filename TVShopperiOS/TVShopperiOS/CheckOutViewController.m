//
//  ViewController+CheckOutViewController.m
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/8/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import "CheckOutButtonViewController.h"
#import "SIMProductViewController.h"

@interface CheckOutButtonViewController ()




@end

@implementation CheckOutButtonViewController{
    
}
- (IBAction)performSegue:(id)sender {
    [self performSegueWithIdentifier: @"checkOut" sender: self];
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"checkOut"])
    {
        SIMProductViewController *checkOutViewController = [segue destinationViewController];
    }
}
*/


@end
