//
//  SecondViewController.h
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element+CoreDataProperties.h"

@interface SecondViewController : UIViewController

@property (strong, nonatomic) UITableView* tableView;
@property (copy, nonatomic) NSString* url;
@property (copy, nonatomic) NSString* titleHeader;
@property (strong, nonatomic) NSManagedObjectContext* context;
@property (strong, nonatomic) Element* element;

@end
