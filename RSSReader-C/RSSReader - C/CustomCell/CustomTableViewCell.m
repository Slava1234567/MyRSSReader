//
//  CustomTableViewCell.m
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id) initWithStyles:(UITableViewCellStyle) stale reuseIdentifier: (NSString*) reuseIdentifier {
    
    self = [super initWithStyle:stale reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.myImageView.image = [UIImage imageNamed:@"Save"];
        self.title = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.title setFont:[UIFont systemFontOfSize:25]];
        self.url = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_myImageView];
        [self addSubview:_title];
        [self addSubview:_url];
        
        self.myImageView.translatesAutoresizingMaskIntoConstraints = false;
        self.title.translatesAutoresizingMaskIntoConstraints = false;
        self.url.translatesAutoresizingMaskIntoConstraints = false;
        
        
        UILayoutGuide *safe = self.safeAreaLayoutGuide;
        NSLayoutConstraint * imageViewTop = [self.myImageView.topAnchor constraintEqualToAnchor:safe.topAnchor constant:10];
        NSLayoutConstraint * imageViewlerding = [self.myImageView.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:10];
        NSLayoutConstraint * imageViewBottom = [self.myImageView.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor constant: - 10];
        NSLayoutConstraint * widthImage = [self.myImageView.widthAnchor constraintEqualToConstant:self.frame.size.height * 2 + 10];
        
        NSLayoutConstraint * titleTop = [self.title.topAnchor constraintEqualToAnchor:safe.topAnchor constant:10];
        NSLayoutConstraint * titleTraning = [self.title.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant: - 5];
        NSLayoutConstraint *imageAndTitle = [self.myImageView.trailingAnchor constraintEqualToAnchor:self.title.leadingAnchor constant: - 10];
        
        NSLayoutConstraint * titleHigth = [self.url.heightAnchor constraintEqualToConstant:self.bounds.size.height / 3 ];
        NSLayoutConstraint * urlBottom = [self.url.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor constant: - 10];
        NSLayoutConstraint * urlTraning = [self.url.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant: - 5];
        NSLayoutConstraint * imageAndUrl = [self.myImageView.trailingAnchor constraintEqualToAnchor:self.url.leadingAnchor constant: - 10];
        NSLayoutConstraint * titleAndUrl = [self.url.topAnchor constraintEqualToAnchor:self.title.bottomAnchor constant:0];
        
        [NSLayoutConstraint activateConstraints:@[imageViewTop, imageViewlerding,titleTop,titleTraning, imageAndTitle,imageAndUrl,titleAndUrl,urlBottom,urlTraning,widthImage,imageViewBottom,titleHigth]];
        
        
    }
    return  self;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
