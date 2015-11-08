//
//  ViewController+CheckOutViewController.m
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/8/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import "CheckOutButtonViewController.h"
#import "SIMProductViewController.h"
#import "TableViewController.h"

@interface CheckOutButtonViewController ()




@end

@implementation CheckOutButtonViewController{
    
}
- (IBAction)performSegue:(id)sender {
    TableViewController *tableViewController = self.navigationController.visibleViewController;
    [self performSegueWithIdentifier: @"checkOut" sender: self];
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"checkOut"])
    {
        TableViewController *tableViewController = self.navigationController.viewControllers[1];
        SIMProductViewController *simProductViewController = [segue destinationViewController];
        simProductViewController.totalAmount = tableViewController.totalPrice;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"checkOut"])
    {
        SIMProductViewController *checkOutViewController = [segue destinationViewController];
    }
}
*/


@end
