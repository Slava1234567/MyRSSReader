//
//  SecondViewController.m
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "SecondViewController.h"
#import "CoreDataManager.h"
#import "CustomTableViewCell.h"
#import "Data+CoreDataClass.h"
#import "Media+CoreDataClass.h"
#import "ThridViewController.h"
#import "DownloadManagerForSecondVC.h"



static NSString* const identifier1 = @"identifier1";
static NSString* const litleImage = @"LitleFoto";
static NSString* const bigImage = @"BigFoto";

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource,NSXMLParserDelegate/*,NSURLSessionDelegate, NSURLSessionDownloadDelegate*/> {
    Data* dataElement;
    Media* media;
    
    
}

@property (strong,nonatomic) NSXMLParser* parser;
@property (strong, nonatomic) NSMutableString* titleC;
@property (strong, nonatomic) NSMutableString* linkC;
@property (strong,nonatomic) NSMutableArray* mediaC;
@property (strong, nonatomic) NSMutableString* pubDateC;
@property (strong, nonatomic) NSMutableString* descroptionC;
@property (copy, nonatomic) NSString* currentElement;

@property (strong, nonatomic) NSMutableArray* arrayDownloadTask;
@property (strong, nonatomic) NSMutableArray* arrayData;
@property (assign, nonatomic) int tagForData;

@property (strong, nonatomic) NSMutableArray* arrayPathForLitleImage;


@end

@implementation SecondViewController

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

//MARK: - Funcs

- (void) addUITableViewWithConstrant {
    
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* top = [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    NSLayoutConstraint* bottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    NSLayoutConstraint* leading = [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint* trailing = [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[top,bottom,leading,trailing]];
}

//MARK: - LifiCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagForData = 0;
    self.arrayPathForLitleImage = [NSMutableArray array];
    self.arrayDownloadTask = [NSMutableArray array];
    self.arrayData = [NSMutableArray array];
    
    [self addUITableViewWithConstrant];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([self.element.data count] == 0) {
        NSURL* url = [NSURL URLWithString:self.url];
        self.parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [self.parser setDelegate:self];
        [self.parser parse];
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"element.title == %@",self.element.title];
        NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
        NSArray* arrayData = [[CoreDataManager shared] getArrayObject:@"Data" withPredicate:predicate And:sortDescriptor];
        
        self.arrayData = [NSMutableArray arrayWithArray:arrayData];
    }
}


//MARK: - UITableViewDataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleHeader;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.arrayData count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomTableViewCell* cell = (CustomTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:identifier1];
    
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyles:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
   
    Data* dataOfElement = self.arrayData[indexPath.row];
    
    cell.title.text = dataOfElement.title;
    cell.url.text = dataOfElement.data;
    
    NSString* path = dataOfElement.path;
    if (indexPath.row == 0){
    NSLog(@"data_of_element_path - %@",path);
}
    NSData* data = [NSData dataWithContentsOfFile:path];
    if (data) {
        cell.myImageView.image = [UIImage imageWithData:data];
    }
    return cell;
}

//MARK: - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThridViewController* vc = [[ThridViewController alloc] init];
    
    Data* data = self.arrayData[indexPath.row];
    vc.descript = data.descript;
    vc.context = self.context;
    vc.data = data;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"data.title == %@", data.title];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
    NSArray* arrayMedia = [[CoreDataManager shared] getArrayObject:@"Media" withPredicate:predicate And:sortDescriptor];
    
    vc.arrayMedia = [NSMutableArray arrayWithArray:arrayMedia];
    
    [self.navigationController pushViewController:vc animated:true];
}

//MARK: - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    self.currentElement = elementName;
    
    if ([self.currentElement isEqualToString:@"item"]) {
        
        dataElement = [NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:self.context];
        
        self.titleC = [[NSMutableString alloc] init];
        self.linkC = [[NSMutableString alloc] init];;
        self.mediaC = [[NSMutableArray alloc] init];;
        self.pubDateC = [[NSMutableString alloc] init];;
        self.descroptionC = [[NSMutableString alloc] init];
    }
    if ([self.currentElement isEqualToString:@"media:content"]) {
        NSString* string = [attributeDict objectForKey:@"url"];
        NSMutableString* media = [[NSMutableString alloc] init];
        [media appendString:string];
        [self.mediaC addObject:media];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        
        dataElement.title = self.titleC;
        dataElement.link = self.linkC;
        dataElement.data = self.pubDateC;
        dataElement.tag = self.tagForData;
        self.tagForData++;
        
        NSDictionary* dictionary = [self getDescriptionAndLitleImage:self.descroptionC];
        NSString* litleUrl = [dictionary allKeys][0];
        NSString* descript = [dictionary objectForKey:litleUrl];
        dataElement.litleUrl = litleUrl;
        dataElement.descript = descript;
        
        for (int i = 0; i < [self.mediaC count] ; i++) {
            media = [NSEntityDescription insertNewObjectForEntityForName:@"Media" inManagedObjectContext:self.context];
            media.tag = i;
            NSString* url = self.mediaC[i];
            media.path = url;
            [dataElement addMediaObject:media];
            
        }
        self.mediaC = [NSMutableArray array];

       
        [self.element addDataObject:dataElement];
        [self.arrayData addObject:dataElement];
        
        [self.context save:nil];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([self.currentElement isEqualToString:@"title"]) {
        [self.titleC appendString:string];
    } else if ([self.currentElement isEqualToString:@"link"]) {
        [self.linkC appendString:string];
    } else if ([self.currentElement isEqualToString:@"pubDate"]) {
        [self.pubDateC appendString:string];
    } else if ([self.currentElement isEqualToString:@"description"]) {
        [self.descroptionC appendString:string];
        
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    DownloadManagerForSecondVC* downlodManager = [[DownloadManagerForSecondVC alloc] init];
    [downlodManager resumeDownloadTask:self.arrayData];
    downlodManager.getPath = ^(NSString *dirName, NSInteger index) {
        __weak typeof(self)weakSelf = self;
        Data* data = weakSelf.arrayData[index];
        data.path = dirName;
        [weakSelf.context save:nil];
        [weakSelf.tableView reloadData];
    };
}

- (NSDictionary*) getDescriptionAndLitleImage: (NSString*) description  {
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    NSArray* firstArray = [description componentsSeparatedByString:@"/>"];
    if ([firstArray count] > 1) {
    NSArray* tempUrlOne = [(NSString*)firstArray[0] componentsSeparatedByString:@" widt"];
    NSArray* tempUrlTwo = [(NSString*)tempUrlOne.firstObject componentsSeparatedByString:@"src="];
    NSString* tempUrl = tempUrlTwo.lastObject;
    NSString* urlImage = [tempUrl substringWithRange:NSMakeRange(1, [tempUrl length] - 2)];
    
    NSString* tempText = firstArray[1];
    NSArray* tempArrayText =[tempText componentsSeparatedByString:@"<br"];
    NSString* text = tempArrayText[0];
    
    [dict setObject:text forKey:urlImage];
    
    } else {
        NSString* text = description;
        NSString* url = @"https://img.tyt.by/thumbnails/n/sport/0e/9/belarus-u17-basket-25-07-18.jpg";
        [dict setObject:text forKey:url];
    }
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithDictionary:dict];
    return dictionary;
}

@end
