//
//  CustomTableViewCell.h
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView* myImageView;
@property (strong, nonatomic) UILabel* title;
@property (strong, nonatomic) UILabel* url;

- (id) initWithStyles:(UITableViewCellStyle) stale reuseIdentifier: (NSString*) reuseIdentifier;

@end
