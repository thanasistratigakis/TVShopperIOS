//
//  ViewController+MoreInfoViewController.h
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import "ViewController.h"

@interface MoreInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabelName;
@property (weak, nonatomic) IBOutlet UILabel *itemLabelCompany;
@property (weak, nonatomic) IBOutlet UILabel *itemLabelPrice;
@property (weak, nonatomic) IBOutlet UITextView *itemTextView;

@property (nonatomic, strong) NSString *itemDesc;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic) int itemPrice;
@property (nonatomic, strong) NSString *itemCompany;
@property (nonatomic, strong) UIImage *itemImage;

@end
