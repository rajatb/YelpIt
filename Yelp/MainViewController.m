//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpCell.h"
#import "SVProgressHUD.h"
#import "YelpModel.h"
#import "MapViewController.h"
#import "MapModel.h"
#import "DetailsViewController.h"


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic)NSArray *yelpModels;
@property(strong, nonatomic)MapModel *mapModel;

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSString *searchTerm;
@property (nonatomic, strong) NSMutableDictionary *filters;

@end

@implementation MainViewController

YelpCell *_stubCell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        self.searchTerm = @"Thai";
        [self searchYelpWith:self.searchTerm];
        [self configureNavigationBar];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UINib *yelpNib = [UINib nibWithNibName:@"YelpCell" bundle:nil];
    [self.tableView registerNib:yelpNib forCellReuseIdentifier:@"YelpCell"];
    _stubCell = [yelpNib instantiateWithOwner:nil options:nil][0];
    self.tableView.rowHeight=130;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table View Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yelpModels.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpCell *yelpCell = [tableView dequeueReusableCellWithIdentifier:@"YelpCell"];
    YelpModel *yelpModel = self.yelpModels[indexPath.row];
    
   yelpCell.count = [NSNumber numberWithLong:indexPath.row + 1];
   yelpCell.yelpModel = yelpModel;
    
    return yelpCell;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 130; 
//}

- (void)configureCell:(YelpCell *)yelpCell atIndexPath:(NSIndexPath *)indexPath
{
    YelpModel *yelpModel = self.yelpModels[indexPath.row];
    
    yelpCell.count = [NSNumber numberWithLong:indexPath.row + 1];
    yelpCell.yelpModel = yelpModel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self configureCell:_stubCell atIndexPath:indexPath];
    [_stubCell layoutSubviews];
    
    CGSize size = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"--> height: %f", size.height);
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma tableViewDelegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *dvc = [[DetailsViewController alloc]init];
    dvc.yelpModel=self.yelpModels[indexPath.row];
    [self.navigationController pushViewController:dvc animated:true];
}

#pragma mark - Call YELP API
- (void)searchYelpWith:(NSString *)searchTerm
{
    [self showProgressWithStatus];
    [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        
        self.yelpModels = [YelpModel yelpModelsWithArray:response[@"businesses"]];
        self.mapModel = [MapModel mapModelWithDictionary:response[@"region"]];

        [self dismissProgress];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
        [self dismissProgress];
    }];
}

- (void)searchYelpWith:(NSString *)searchTerm filters:(NSDictionary*)filters
{
    [self showProgressWithStatus];
    [self.client searchWithTerm:searchTerm searchWithFilters:filters success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"response: %@", response);
        
        self.yelpModels = [YelpModel yelpModelsWithArray:response[@"businesses"]];
        self.mapModel = [MapModel mapModelWithDictionary:response[@"region"]];
        
        [self dismissProgress];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
        [self dismissProgress];
    }];
}



- (void)configureNavigationBar
{
    
    
    //UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    UISearchBar *searchBar=[[UISearchBar alloc] init];
    searchBar.delegate=self;
    searchBar.placeholder=@"Search";
    searchBar.showsCancelButton=NO;
    self.navigationItem.titleView = searchBar;
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(goToFilterView)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(goToMapView)];
    self.navigationItem.rightBarButtonItem = map;
}
#pragma mark - Action
-(void)goToFilterView {
    FilterViewController *fvc = [[FilterViewController alloc]init];
    fvc.delegate=self;
    [fvc.filters setValuesForKeysWithDictionary:self.filters];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    
    //[ self.navigationController pushViewController:fvc animated:true];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)goToMapView {
    MapViewController *mvc = [[MapViewController alloc]init];
    mvc.yelpModels = self.yelpModels;
    mvc.mapModel = self.mapModel;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - Search Bar Delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"I am here!");
    searchBar.showsCancelButton = YES;
    return YES;
}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
// 
//     NSLog(@"Text: %@",searchText);
//    [self searchYelpWith:searchText];
//
//}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.searchTerm=searchBar.text;
    [self searchYelpWith:searchBar.text];
    searchBar.showsCancelButton = NO;
    [self.filters removeAllObjects];
}

#pragma mark - FilterDelegate 
-(void) searchWithFilters:(NSMutableDictionary *)filters {
    NSLog(@"Searching with Filters");
    self.filters=filters;
    NSLog(@"%@", filters);
    [self searchYelpWith:self.searchTerm filters:filters];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - SVProgressHUD Methods


- (void)showProgressWithStatus {
    [SVProgressHUD showWithStatus:@"Loading..." ];
}

- (void)dismissProgress {
    [SVProgressHUD dismiss];
}

@end
