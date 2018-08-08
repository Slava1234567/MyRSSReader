//
//  DownloadManagerForSecondVC.h
//  RSSReader - C
//
//  Created by Slava on 8/8/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetPath)(NSString* dirName, NSInteger index) ;

@interface DownloadManagerForSecondVC : NSObject

@property (strong, nonatomic) NSURLSession* session;
@property (copy,nonatomic) GetPath getPath;

- (void) resumeDownloadTask:(NSArray*)arrayData;

@end
