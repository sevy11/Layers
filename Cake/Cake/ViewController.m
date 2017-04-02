//
//  ViewController.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "Config.h"
#import "UserManager.h"
#import "AWSCognitoIdentityProvider.h"
#import "OutfitTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *outfits;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.outfits = [NSArray array];
    self.outfits = @[@"top", @"bottom", @"under"];
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.title = [[UserManager sharedManager].userPool currentUser].username;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (OutfitTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OutfitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutfitCell" forIndexPath:indexPath];
    return cell;
}


- (IBAction)loginAction:(UIButton *)sender {
    [self performSegueWithIdentifier:kLoginSegue sender:self];
}

@end
