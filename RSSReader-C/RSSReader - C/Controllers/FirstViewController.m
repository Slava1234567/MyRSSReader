//
//  FirstViewController.m
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "FirstViewController.h"
#import "HTMLParse.h"
#import "CoreDataManager.h"
#import "Element+CoreDataClass.h"
#import "Content+CoreDataClass.h"
#import "SecondViewController.h"

static NSString* const identifier = @"identifier";

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) HTMLParse* parse;
@property(copy, nonatomic) NSArray* arrayContent;

@end

@implementation FirstViewController

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
    }
    return _tableView;
}

//MARK: - funcs

- (void) addUITableViewWithConstraint {
    
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* top = [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    NSLayoutConstraint* bottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    NSLayoutConstraint* leading = [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint* trailing = [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[top,bottom,leading,trailing]];
}

//MARK: - LifeCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"TYT.BY";
    self.arrayContent = [NSArray array];
    
    self.context = CoreDataManager.shared.persistentContainer.viewContext;
    
    [self addUITableViewWithConstraint];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    NSArray* arrayContent = [[CoreDataManager shared] getArrayObject:@"Content" withPredicate:nil And:sortDescriptor];
    
    if ([arrayContent count] == 0) {
        
        self.parse = [[HTMLParse alloc] init];
        __weak typeof(self)weakSelf = self;
        [self.parse  getArrayDataForUI:^(NSArray *result) {
            weakSelf.arrayContent = [NSArray arrayWithArray:result];
            [weakSelf.tableView reloadData];
        }];
    } else {
        self.arrayContent = [NSArray arrayWithArray:arrayContent];
    }
}

//MARK: - UITableViewDataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return   [self.arrayContent count];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Content* content = self.arrayContent[section];
    return [content.element count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Content* content = self.arrayContent[indexPath.section];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"content.mainTitle == %@", content.mainTitle];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
    NSArray* arrayElement = [[CoreDataManager shared] getArrayObject:@"Element" withPredicate:predicate And:sortDescriptor];
    Element* element = arrayElement[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:23];
    cell.textLabel.text = element.title;
    cell.imageView.image = [UIImage imageNamed:@"tyt1"];
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Content* content = self.arrayContent[section];
    return content.mainTitle;
}

//MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:true];

    Content* content = self.arrayContent[indexPath.section];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"content.mainTitle == %@", content.mainTitle];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
    NSArray* arrayElement = [[CoreDataManager shared] getArrayObject:@"Element" withPredicate:predicate And:sortDescriptor];
    Element* element = arrayElement[indexPath.row];
    
    SecondViewController* vc = [[SecondViewController alloc] init];
    vc.title = element.content.mainTitle;
    vc.titleHeader = element.title;
    vc.url = element.url;
    vc.context = self.context;
    vc.element = element;

    [self.navigationController pushViewController:vc animated:true];
}


@end














