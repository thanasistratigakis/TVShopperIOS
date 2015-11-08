//
//  ViewController+SIMProductViewController.m
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import <Simplify/SIMChargeCardViewController.h>

//1. Sign up to be a SIMChargeViewControllerDelegate so that you get the callback that gives you a token
@interface SIMProductViewController: UIViewController <SIMChargeCardViewControllerDelegate>

@end

@implementation SIMProductViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //2. Create a SIMChargeViewController with your public api key
    SIMChargeCardViewController *chargeVC = [[SIMChargeCardViewController alloc] initWithPublicKey:@"sbpb_Y2YyYjEzNzgtZDgwNi00NjJlLTk1NmItZDA3MTc2NzJhNTk5"];
    
    //3. Assign your class as the delegate to the SIMChargeViewController class which takes the user input and requests a token
    chargeVC.delegate = self;
    
    //4. Add SIMChargeViewController to your view hierarchy
    [self presentViewController:chargeVC animated:YES completion:nil];
    
}

#pragma mark SIMChargeCardViewControllerDelegate callback
//5. This method will be called on your class whenever the user presses the Charge Card button and tokenization succeeds
-(void)creditCardTokenProcessed:(SIMCreditCardToken *)token {
    
    //Process the provided token
    NSLog(@"Token:%@", token.token);
    
}

@end
