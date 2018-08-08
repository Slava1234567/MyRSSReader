//
//  DownloadManager.h
//  RSSReader - C
//
//  Created by Slava on 8/7/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetData) (NSData* data,NSURLSessionDownloadTask* downloadTask);

@interface DownloadManager : NSObject

@property (strong, nonatomic) NSURLSession* session;
@property(copy, nonatomic) NSArray* arrayMedia;
@property(copy,nonatomic) GetData getData;

- (void) resumeDownloadTask:(NSArray*)arrayMedia;

@end
