//
//  ViewController+SIMProductViewController.m
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import <Simplify/SIMChargeCardViewController.h>
#import <Simplify/SIMResponseViewController.h>
#import "TableViewController.h"
#import <Parse/Parse.h>
//1. Sign up to be a SIMChargeViewControllerDelegate so that you get the callback that gives you a token
@interface SIMProductViewController: UIViewController <SIMChargeCardViewControllerDelegate>

@property (strong, nonatomic) SIMChargeCardViewController *chargeVC;

@property (nonatomic) BOOL succeeded;
@property (nonatomic) BOOL processing;


@end

@implementation SIMProductViewController

- (void)setItemsInCart:(Boolean)inCart {
    PFQuery *query = [PFQuery queryWithClassName:@"Items"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        for (int i = 0; i < objects.count; i++) {
            [objects[i] setObject:[NSNumber numberWithBool:inCart] forKey:@"inCart"];
            [objects[i] saveInBackground];
        }
    }];
}

- (IBAction)pressedDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double theTotalAmount = [defaults doubleForKey:@"totalPrice"];
    
    //2. Create a SIMChargeViewController with your public api key
    
    if (!self.succeeded && !self.processing) {
        self.processing = true;
        
        self.chargeVC = [[SIMChargeCardViewController alloc] initWithPublicKey:@"sbpb_Y2YyYjEzNzgtZDgwNi00NjJlLTk1NmItZDA3MTc2NzJhNTk5"];
        self.chargeVC.defaultCardNumber = @"5555555555554444";
        self.chargeVC.defaultExpiration = @"0220";
        self.chargeVC.amount = [[NSDecimalNumber alloc] initWithDouble:theTotalAmount];//INPUT THE REAL VALUE LATER
        
        //3. Assign your class as the delegate to the SIMChargeViewController class which takes the user input and requests a token
        self.chargeVC.delegate = self;
        
        //4. Add SIMChargeViewController to your view hierarchy
        [self presentViewController:self.chargeVC animated:YES completion:nil];
    }else{
        self.view.backgroundColor = [UIColor greenColor];
    }
}

#pragma mark SIMChargeCardViewControllerDelegate callback
//5. This method will be called on your class whenever the user presses the Charge Card button and tokenization succeeds
-(void)creditCardTokenProcessed:(SIMCreditCardToken *)token {
    
    
    //NSLog(@"Token:%@", token.token);
    
    self.processing = true;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double theTotalAmount = [defaults doubleForKey:@"totalPrice"];
    NSString *amount = [NSString stringWithFormat:@"%f", theTotalAmount];
    
    NSString *paramsString = [NSString stringWithFormat:@"amount=%@&simplifyToken=%@",amount,token.token];
    
    NSURL *url= [NSURL URLWithString:@"https://tv-shopper.herokuapp.com/charge.php"];
    //NSLog(@"url = %@", url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSLog(@"response = %@", response);
        if (error) {
            NSLog(@"error:%@", error);
        }else{
            NSDictionary *responseObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"response = %@", responseObj);
            
            if ([responseObj[@"status"] isEqualToString:@"APPROVED"]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //modify the ui
                    
                    [self setSucceeded:true];
                    self.processing = false;
                    [self setItemsInCart:false];
                    //[self dismissViewControllerAnimated:YES completion:nil];
                    //[self performSegueWithIdentifier:@"ShowSuccess" sender:self];
                 });
                
            }else{
                NSLog(@"Declined!");
                self.processing = false;
            }
            
        }
        
    }];
    
    [task resume];
}

#pragma mark - SIMChargeViewControllerDelegate Protocol

-(void)chargeCardCancelled {
    
    //User cancelled the SIMChargeCardViewController
    NSLog(@"User Cancelled");
    
}

-(void)creditCardTokenFailedWithError:(NSError *)error {
    NSLog(@"Credit Card Token Failed with error:%@", error.localizedDescription);
    
    // create effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // add effect to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;
    
    // add the effect view to the image view
    
    NSString *errorDescription = @"There was a problem with the token.\nPlease try again.";
    SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:effectView
                                                                                         primaryColor:[UIColor blackColor]
                                                                                                title:@"Failure."
                                                                                          description:errorDescription];
    [self presentViewController:viewController animated:YES completion:nil];
}



@end
