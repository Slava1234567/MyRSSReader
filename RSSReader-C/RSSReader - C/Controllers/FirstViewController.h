//
//  FirstViewController.h
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSManagedObjectContext* context;

@end
