//
//  UITableViewController+TableViewController.h
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *itemPriceArray;
@property (nonatomic, strong) NSMutableArray *itemDescArray;
@property (nonatomic, strong) NSMutableArray *itemCompanyArray;
@property (nonatomic, strong) NSMutableArray *itemNameArray;
@property (nonatomic, strong) NSMutableArray *itemPictureArray;
@property (nonatomic, strong) NSMutableArray *itemInCartArray;
@property (nonatomic, strong) UIImage *currentObjectImage;
@property (nonatomic, strong) UIImage *hatImage;
/*
@property (strong, nonatomic) NSMutableArray *itemPriceArray;
NSMutableArray *itemDescArray;
NSMutableArray *itemCompanyArray;
NSMutableArray *itemNameArray;
NSMutableArray *itemPictureArray;
NSMutableArray *itemInCartArray;
UIImage *bowTieImage;
UIImage *hatImage;*/

@end
