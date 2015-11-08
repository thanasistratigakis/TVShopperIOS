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
#import <Simplify/Simplify.h>

@interface TableViewController ()




@end

@implementation TableViewController{
    int currentIndex;
    int counter;
    NSMutableArray *pffilesArray;
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
    pffilesArray = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Items"];
    [query whereKey:@"inCart" notEqualTo:[NSNumber numberWithBool:false]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(int i = 0; i < objects.count; i++){
            PFObject *object = [objects objectAtIndex:i];
            [self.itemCompanyArray addObject:object[@"Company"]];
            [self.itemDescArray addObject:object[@"Description"]];
            NSNumber *price = [object objectForKey:@"Price"];
            [self.itemPriceArray addObject:price];
            [self.itemNameArray addObject:object[@"Name"]];
            [pffilesArray addObject:object[@"Picture"]];
        }
        counter = 0;
        [self loadPictures];
    }
  ];
}

-(void)loadPictures{
    if (counter < pffilesArray.count) {
        PFFile *picture = [pffilesArray objectAtIndex:counter];
        [picture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                [self.itemPictureArray addObject:[[UIImage alloc]initWithData:data]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                counter++;
                [self loadPictures];
            });
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemPictureArray.count;
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
    TheCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"XIBTableViewCell" bundle:nil]forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    [cell.itemCompany setText:self.itemCompanyArray[indexPath.row]];
    [cell.itemName setText:self.itemNameArray[indexPath.row]];
    int price = [self.itemPriceArray[indexPath.row] intValue];
    NSString *aPrice = [NSString stringWithFormat:@"$%i%@", price, @".99"];
    [cell.itemPrice setText:aPrice];
    [cell.itemImageView setImage:self.itemPictureArray[indexPath.row]];
    
    // Configure the cell.
    //cell.set
    //    cell.setItemPrice = [recipes objectAtIndex:indexPath.row];
    return cell;
}

@end
