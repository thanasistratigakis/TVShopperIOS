//
//  TableViewController.m
//  TVShopperiOS
//
//  Created by Arthur Araujo on 11/7/15.
//  Copyright © 2015 Arthur Araujo. All rights reserved.
//

#import "TableViewController.h"
#import "TheCustomTableViewCell.h"
#import "MoreInfoViewController.h"
#import <Parse/Parse.h>

@interface TableViewController ()




@end

@implementation TableViewController{
    int currentIndex;
}

- (IBAction)refresh:(id)sender {
    //CHECK IF INCART IS FALSE OR TRUE
    //ADD THE COMPANY IN THE CELLS
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.;
    self.itemPriceArray = [[NSMutableArray alloc] init];
    self.itemDescArray = [[NSMutableArray alloc] init];
    self.itemCompanyArray = [[NSMutableArray alloc] init];
    self.itemNameArray = [[NSMutableArray alloc] init];
    self.itemPictureArray = [[NSMutableArray alloc] init];
    self.itemInCartArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Items"];
    [query getObjectInBackgroundWithId:@"bTdMmJgo9F" block:^(PFObject *bowTie, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        [self.itemCompanyArray addObject:bowTie[@"Company"]];
        [self.itemDescArray addObject:bowTie[@"Description"]];
        NSNumber *price = [bowTie objectForKey:@"Price"];
        [self.itemPriceArray addObject:price];
        [self.itemNameArray addObject:bowTie[@"Name"]];
        [self.itemInCartArray addObject:bowTie[@"inCart"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            PFFile *picture = [bowTie objectForKey:@"Picture"];
            [picture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    self.bowTieImage = [[UIImage alloc]initWithData:data];
                    [self.itemPictureArray addObject:self.bowTieImage];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
        });
    }];
    
    
    PFQuery *queryTwo = [PFQuery queryWithClassName:@"Items"];
    [queryTwo getObjectInBackgroundWithId:@"A77QNQKCPA" block:^(PFObject *hat, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        [self.itemCompanyArray addObject:hat[@"Company"]];
        [self.itemDescArray addObject:hat[@"Description"]];
        NSNumber *price = [hat objectForKey:@"Price"];
        [self.itemPriceArray addObject:price];
        [self.itemNameArray addObject:hat[@"Name"]];
        [self.itemInCartArray addObject:hat[@"inCart"]];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        PFFile *picture = [hat objectForKey:@"Picture"];
        [picture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                self.hatImage = [[UIImage alloc]initWithData:data];
                [self.itemPictureArray addObject:self.hatImage];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                });
            }];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemPriceArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
//-(UITableView)t

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moreInfoSegue"])
    {
        MoreInfoViewController *moreInfoViewController = [segue destinationViewController];
        moreInfoViewController.itemDesc = self.itemDescArray[currentIndex];
        moreInfoViewController.itemName = self.itemNameArray[currentIndex];
        moreInfoViewController.itemPrice = [self.itemPriceArray[currentIndex] intValue];
        moreInfoViewController.itemCompany = self.itemCompanyArray[currentIndex];
        moreInfoViewController.itemImage = self.itemPictureArray[currentIndex];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentIndex = indexPath.row;
    [self performSegueWithIdentifier: @"moreInfoSegue" sender: self];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    if([self.itemInCartArray[indexPath.row] boolValue] == false){
        TheCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"XIBTableViewCell" bundle:nil]forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        
        cell.itemCompany.text=@"";
        cell.itemPrice.text=@"";
        cell.itemName.text=@"";
        cell.itemImageView.image=nil;
        
        return cell;
    }else{
        TheCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"XIBTableViewCell" bundle:nil]forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        
        [cell.itemCompany setText:self.itemCompanyArray[indexPath.row]];
        [cell.itemName setText:self.itemNameArray[indexPath.row]];
        int price = [self.itemPriceArray[indexPath.row] intValue];
        NSString *aPrice = [NSString stringWithFormat:@"$%i%@", price, @".00"];
        [cell.itemPrice setText:aPrice];
        [cell.itemImageView setImage:self.itemPictureArray[indexPath.row]];
        
        // Configure the cell.
        //cell.set
        //    cell.setItemPrice = [recipes objectAtIndex:indexPath.row];
        return cell;
    }
}

@end
