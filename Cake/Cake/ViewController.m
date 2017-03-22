//
//  ViewController.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "Config.h"
#import "APIClient.h"
#import "User+CoreDataClass.h"
#import "AWSCognitoIdentityProvider.h"
#import "OutfitTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (OutfitTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OutfitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OutfitTableViewCell reuseIdentifier]];
    return cell;
}


- (IBAction)loginAction:(UIButton *)sender {
    [self performSegueWithIdentifier:kLoginSegue sender:self];
}

@end
