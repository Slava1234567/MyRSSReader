//
//  DownloadManager.m
//  RSSReader - C
//
//  Created by Slava on 8/7/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "DownloadManager.h"
#import "Media+CoreDataClass.h"

@interface DownloadManager()<NSURLSessionDelegate,NSURLSessionDownloadDelegate>

@property(strong, nonatomic) NSMutableArray* arrayDownloadTask;

@end

@implementation DownloadManager

- (NSURLSession* )session {
    if (!_session) {
        NSURLSessionConfiguration* conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void) resumeDownloadTask:(NSArray*)arrayMedia {
    
    self.arrayDownloadTask = [NSMutableArray array];
    
    for (Media* media in arrayMedia) {
        NSString* str = [NSString stringWithString:media.path];
        NSURL* url = [NSURL URLWithString:str];
        NSURLSessionDownloadTask* downloadTask = [self.session downloadTaskWithURL:url];
        [self.arrayDownloadTask addObject:downloadTask];
        [downloadTask resume];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSData* data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    NSURLSessionDownloadTask* task = self.arrayDownloadTask[downloadTask.taskIdentifier - 1];
    self.getData(data,task);
    });
    }

@end
