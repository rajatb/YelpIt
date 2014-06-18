//
//  FilterViewController.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "SwitchCell.h"
#import "SectionFilter.h"
#import "FilterCell.h"
#import "FilterModel.h"



@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray const* sections;
@property (strong, nonatomic) NSArray const* deals;
@property (strong, nonatomic) NSArray const* distance;
@property (strong, nonatomic) NSArray const* sort;
@property (strong, nonatomic) SectionFilter const* category;
@property (strong, nonatomic) NSDictionary const* sectionFilterNames;
@property (strong, nonatomic) NSMutableDictionary *rowSelectedPerSection;
@property (strong, nonatomic) NSMutableDictionary *collapsedRowPerSection;

@property (strong, nonatomic) NSDictionary *sectionsDict;



typedef NS_ENUM(NSInteger, FILTER_SECTION) {
    DEALS,
    DISTANCE,
    SORT,
    CATEGORY
};

@end

NSInteger numOfSection = 4;

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.sections = [NSArray arrayWithObjects:@"Deals", @"Distance", @"Sort", @"Category", nil];
        self.deals = [NSArray arrayWithObjects:@[@"deals_filter",@"Offering A Deal"],@[@"second_toggle_filter",@"Another Filter"] ,nil];
        self.distance=[NSArray arrayWithObjects:@[@0,@"Auto"],@[@(0.3),@"0.3 miles"] ,@[@5,@"5 miles"] ,@[@20,@"20 miles"] ,nil];
        self.sort = [NSArray arrayWithObjects:@[@0,@"Best Match"],@[@1,@"Distance"] , @[@2,@"Highest Rated"], nil];
        self.category = [SectionFilter sectionFilterWithCategoryFilters];
        
        
        self.sectionsDict = [NSDictionary dictionaryWithObjectsAndKeys:self.deals,[NSNumber numberWithLong:DEALS],
                             self.distance, [NSNumber numberWithLong:DISTANCE],
                             self.sort ,[NSNumber numberWithLong:SORT],
                             self.category.filterModels, @(CATEGORY),
                             nil];
        self.sectionFilterNames = [NSDictionary dictionaryWithObjectsAndKeys:@"radius_filter",[NSNumber numberWithLong:DISTANCE],
                                   @"sort", [NSNumber numberWithLong:SORT],
                                   nil];
        self.filters=[NSMutableDictionary dictionary];
        self.rowSelectedPerSection = [NSMutableDictionary dictionary];
        self.collapsedRowPerSection = [NSMutableDictionary dictionary];
        
        self.collapsedRowPerSection[@(CATEGORY)]=@YES;
        self.collapsedRowPerSection[@(DISTANCE)]=@YES;
        self.collapsedRowPerSection[@(SORT)]=@YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    UINib *switchNib = [UINib nibWithNibName:@"SwitchCell" bundle:nil];
    [self.tableView registerNib:switchNib forCellReuseIdentifier:@"SwitchCell"];
    
    UINib *filterNib = [UINib nibWithNibName:@"FilterCell" bundle:nil];
    [self.tableView registerNib:filterNib forCellReuseIdentifier:@"FilterCell"];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onSearchButton)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.sections.count;
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.sectionsDict objectForKey:[NSNumber numberWithLong:section]];
    NSUInteger numColapsedRow;
    numColapsedRow = (section == CATEGORY) ? self.category.numOfRowsToShowWhenCollapsed +1 : 1;
    return [self.collapsedRowPerSection[@(section)] boolValue] ? numColapsedRow : array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *filterSectionsArray=[self arrayForFilter:indexPath.section];
   
    switch (indexPath.section) {
        case DEALS: {
            SwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
            switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
            switchCell.toggleFilterLabel.text = filterSectionsArray[indexPath.row][1];
            NSString *filterKey=filterSectionsArray[indexPath.row][0];
            
            if (self.filters[filterKey]) {
                switchCell.switchValue.on = YES;
            } else {
                switchCell.switchValue.on = NO;
            }
            
            switchCell.switchValue.tag=indexPath.row;
            [switchCell.switchValue addTarget:self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
            return switchCell;
        }
        
        case DISTANCE: {
           return [self createCell:indexPath filterSectionsArray:filterSectionsArray];
            
        }
            
        case SORT:{
            return [self createCell:indexPath filterSectionsArray:filterSectionsArray];
            
        }
        case CATEGORY:{
            FilterCell *filterCell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell"];
            
            if(([self.collapsedRowPerSection[@(indexPath.section)] boolValue])&&(indexPath.row == self.category.numOfRowsToShowWhenCollapsed)){
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                
                cell.textLabel.text=@"See All";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                return cell;
            }

            [filterCell setFilterModel:filterSectionsArray[indexPath.row]];
            return filterCell;
        }
 
        default:
            break;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell; 
    
}

#pragma mark - Helper methond for Creating a cell.

- (UITableViewCell*)createCell:(NSIndexPath *)indexPath filterSectionsArray:(NSArray *)filterSectionsArray {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    NSNumber *selectedIndex= self.rowSelectedPerSection[@(indexPath.section)];
    NSString *filter = self.sectionFilterNames[@(indexPath.section)];
    if ([self.collapsedRowPerSection[@(indexPath.section)] boolValue]) {
        
        cell.accessoryView = [self createNavigateDownButton];
        
        if (selectedIndex) {
            cell.textLabel.text = filterSectionsArray[[selectedIndex integerValue]][1];
            return cell;
        } else if (self.filters[filter]) {
            for (NSArray *rowValueArray in filterSectionsArray) {
                if ([self.filters[filter] isEqual:rowValueArray[0]]) {
                    cell.textLabel.text = rowValueArray[1];
                    return cell;
                }
            }
            
        }
    }
    
    
    
    if ([self.filters[filter] isEqual:filterSectionsArray[indexPath.row][0]] ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = filterSectionsArray[indexPath.row][1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     NSArray *filterSectionsArray=[self arrayForFilter:indexPath.section];
    
    if(indexPath.section == CATEGORY){
        //if its collapsed and SEE all hit! toggle
        if ([self.collapsedRowPerSection[@(indexPath.section)] boolValue] && (indexPath.row == self.category.numOfRowsToShowWhenCollapsed)) {
           
            self.collapsedRowPerSection[@(indexPath.section)]= @(![self.collapsedRowPerSection[@(indexPath.section)] boolValue]);
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        } else {  //Select it
            FilterModel *selectedModel = filterSectionsArray[indexPath.row];
            //flip the selection
            FilterCell *cell = (FilterCell*)[tableView cellForRowAtIndexPath:indexPath];
            
            if(selectedModel.isSelected){
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            selectedModel.isSelected = !(selectedModel.isSelected);
            //get the filterKey and set to the filters array
            NSString *filterKey = self.category.sectionFilterName;
            if ([self.filters objectForKey:filterKey]) {
                [self.filters removeObjectForKey:filterKey];
            }
            self.filters[filterKey]=self.category.getNameOfFiltersSelected;
        }
              
              
    } else { //section is not category
        //if not collapsed. choose stuff
        if (![self.collapsedRowPerSection[@(indexPath.section)] boolValue]) {
            
                        NSString *filterKey= [self.sectionFilterNames objectForKey:[NSNumber numberWithLong:indexPath.section]];
                        if ([self.filters objectForKey:filterKey]) {
                            [self.filters removeObjectForKey:filterKey];
                        }
                        [self.filters setObject:[self arrayForFilter:indexPath.section][indexPath.row][0] forKey:filterKey];
            
                        NSInteger selectedIndex= [self.rowSelectedPerSection[@(indexPath.section)] integerValue];
                        NSLog(@"%@",self.rowSelectedPerSection[@(indexPath.section)]);
            
                        if (![self.rowSelectedPerSection[@(indexPath.section)] isKindOfClass:[NSNull class]]) {
                            UITableViewCell *cell = [tableView cellForRowAtIndexPath:
                                                     [NSIndexPath indexPathForRow:selectedIndex inSection:indexPath.section]];
                            cell.accessoryType = UITableViewCellAccessoryNone;
                        }
            
                        self.rowSelectedPerSection[@(indexPath.section)] = @(indexPath.row);
                        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        
        //will have to toggle anyways
         self.collapsedRowPerSection[@(indexPath.section)]= @(![self.collapsedRowPerSection[@(indexPath.section)] boolValue]);
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

#pragma mark - table View

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sections[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

#pragma mark - Action Method
-(void) onSearchButton {
    
    [self.delegate searchWithFilters:self.filters];
}

-(void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction) flip: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    NSString* filterKey = [self arrayForFilter:DEALS][onoff.tag][0];
    if (onoff.on) {
        self.filters[filterKey]=@YES;
    } else {
        [self.filters removeObjectForKey:filterKey];
    }
    NSLog(@"%@%@",filterKey, onoff.on ? @"On" : @"Off");
}

#pragma mark -helper methods
- (NSArray *)arrayForFilter:(NSInteger)filter {
    NSArray *filterSectionsArray=[self.sectionsDict objectForKey:[NSNumber numberWithLong:filter]];
    return filterSectionsArray;
}

- (UIButton *)createNavigateDownButton {
    UIImage *image =  [UIImage imageNamed:@"navigate-down.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

@end
