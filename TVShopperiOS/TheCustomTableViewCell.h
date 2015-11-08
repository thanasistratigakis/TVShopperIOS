//
//  UITableViewCell+a.h
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemCompany;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@end
