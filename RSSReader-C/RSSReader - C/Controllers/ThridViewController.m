//
//  ThridViewController.m
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#import "ThridViewController.h"
#import "Data+CoreDataClass.h"
#import "CoreDataManager.h"
#import "Media+CoreDataClass.h"
#import "DownloadManager.h"

@interface ThridViewController ()

@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) UIScrollView* myScrollView;
@property  (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) NSMutableArray* arrayTask;
@property (strong,nonatomic) NSMutableArray* arrayImageView;

@property (strong, nonatomic) AVPlayer* player;
@property (strong, nonatomic) NSMutableArray* regularArray;
@property (strong, nonatomic) NSMutableArray* compactArray;

@end

@implementation ThridViewController


- (void) setTextViewAndScrollView {

    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    CGRect frame = CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height / 2.5);
    self.myScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.myScrollView.pagingEnabled = YES;
    [self.view addSubview:self.textView];
    [self.view addSubview:self.myScrollView];
    [self.view addSubview:self.label];

    self.textView.translatesAutoresizingMaskIntoConstraints = false;
    self.myScrollView.translatesAutoresizingMaskIntoConstraints = false;
    self.label.translatesAutoresizingMaskIntoConstraints = false;
    
      NSLayoutConstraint* bottomText = [self.textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:- 10];
      NSLayoutConstraint* topScroll = [self.myScrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: 80];
      NSLayoutConstraint* tralingLabel = [self.label.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:- 10];
     NSLayoutConstraint* tralingText = [self.textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:- 10];
   
    self.compactArray = [NSMutableArray arrayWithObjects:
                         [self.textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                         [self.myScrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                         [self.myScrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                         [self.myScrollView.heightAnchor constraintEqualToConstant:self.view.bounds.size.height / 2.5],
                         [self.label.topAnchor constraintEqualToAnchor:self.myScrollView.bottomAnchor constant:15],
                         [self.label.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                         [self.label.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor constant: - 10],
                         nil];
    
   self.regularArray = [NSMutableArray arrayWithObjects:
                        [self.label.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80],
                        [self.label.leadingAnchor constraintEqualToAnchor:self.myScrollView.trailingAnchor constant: 10],
                        [self.label.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor  constant:10],
                        [self.textView.leadingAnchor constraintEqualToAnchor:self.myScrollView.trailingAnchor constant:10],
                        [self.myScrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:10],
                        [self.myScrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
                        [self.myScrollView.widthAnchor constraintEqualToConstant:self.view.bounds.size.height / 2.5],
                        nil];
    
    [NSLayoutConstraint activateConstraints:@[tralingText,bottomText,topScroll,tralingLabel]];
    
    [self.myScrollView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.myScrollView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
   
    self.myScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * [self.arrayMedia count], self.view.bounds.size.height / 2.5);
}

- (void) addImageInScrollView {
    self.arrayImageView = [NSMutableArray array];
    
    for (int i = 0; i < [self.arrayMedia count] ; i++) {
        CGRect rect = CGRectMake(self.view.bounds.size.width * i, 0, self.myScrollView.bounds.size.width, self.myScrollView.bounds.size.height);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:rect];
        
        imageView.backgroundColor = [UIColor grayColor];
        
        [self.arrayImageView addObject:imageView];
        [self.myScrollView addSubview:imageView];
    }
}

- (void) traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        [NSLayoutConstraint deactivateConstraints:self.regularArray];
        [NSLayoutConstraint activateConstraints:self.compactArray];
    } else {
        [NSLayoutConstraint deactivateConstraints:self.compactArray];
        [NSLayoutConstraint activateConstraints:self.regularArray];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTextViewAndScrollView];
    [self addImageInScrollView];
    
    DownloadManager* download = [[DownloadManager alloc] init];
    [download resumeDownloadTask:self.arrayMedia];
    __weak typeof(self)weakSelf = self;
    download.getData = ^(NSData* data,NSURLSessionDownloadTask* downloadTask) {
        NSInteger index = downloadTask.taskIdentifier - 1;
        UIImageView* imageView = weakSelf.arrayImageView[index];
        
        NSString* str = [[downloadTask response] suggestedFilename];
        if ([str hasSuffix:@"mp4"]) {
            
            Media* media = weakSelf.arrayMedia[index];
            NSLog(@"PATH_For_VIDEO - %@",media.path);
            weakSelf.player = [AVPlayer playerWithURL:[NSURL URLWithString:media.path]];
            AVPlayerLayer* playerLayer = [AVPlayerLayer layer];
            playerLayer.player = weakSelf.player;
            playerLayer.frame = imageView.bounds;
             playerLayer.backgroundColor = [UIColor blackColor].CGColor;
            [imageView.layer addSublayer:playerLayer];
            [weakSelf.player play];
            UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(handlerTapGesture:)];
            [imageView addGestureRecognizer:tapGesture];
            imageView.userInteractionEnabled = YES;
            
        } else {
            UIImage* image = [UIImage imageWithData:data];
            [imageView setImage:image];
        }
    };
    
    self.textView.text = self.descript;
    self.textView.font = [UIFont systemFontOfSize:20] ;
    self.label.text = self.data.title;
    self.label.font = [UIFont systemFontOfSize:30];
    [self.label setNumberOfLines:5];
    
}

- (void)handlerTapGesture:(UITapGestureRecognizer*)tapGesture {
    
    if (self.player.rate == 0) {
        [self.player play];
    } else {
        [self.player pause];
    }
}



@end
