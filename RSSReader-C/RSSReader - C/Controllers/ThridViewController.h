//
//  ThridViewController.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Data+CoreDataClass.h"

@interface ThridViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext* context;
@property(strong, nonatomic) NSMutableArray* arrayMedia;
@property (strong, nonatomic) Data* data;
@property (copy, nonatomic)NSString* descript;

@end
