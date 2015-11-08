//
//  ViewController+MoreInfoViewController.m
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import "MoreInfoViewController.h"

@interface MoreInfoViewController ()

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.;
    self.itemLabelCompany.text = [NSString stringWithFormat:@"By %@",self.itemCompany];
    self.itemLabelPrice.text = [NSString stringWithFormat:@"$%i",self.itemPrice];
    self.title = self.itemName;
    self.itemLabelName.text = self.itemName;
    [self.itemImageView setImage:self.itemImage];
    [self.itemTextView setUserInteractionEnabled:false];
    self.itemTextView.text = self.itemDesc;
}

@end
