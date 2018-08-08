//
//  DownloadManagerForSecondVC.m
//  RSSReader - C
//
//  Created by Slava on 8/8/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "DownloadManagerForSecondVC.h"
#import "Data+CoreDataClass.h"

@interface DownloadManagerForSecondVC()<NSURLSessionDelegate,NSURLSessionDownloadDelegate>

@property (strong, nonatomic) NSMutableArray* arrayDownloadTask;

@end

@implementation DownloadManagerForSecondVC

- (NSURLSession* )session {
    if (!_session) {
        NSURLSessionConfiguration* conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void) resumeDownloadTask:(NSArray*)arrayData {
    
    self.arrayDownloadTask = [NSMutableArray array];
    for (Data* data in arrayData) {
        NSURL * url = [NSURL URLWithString:data.litleUrl];
        NSURLSessionDownloadTask* downloadTask = [self.session downloadTaskWithURL:url];
        [downloadTask resume];
        [self.arrayDownloadTask addObject:downloadTask];
    }
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    NSInteger index = downloadTask.taskIdentifier - 1;
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* dirDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString* dirApp = [dirDoc stringByAppendingPathComponent:[NSString stringWithFormat:@"/Foto@%ld/",(long)index]];
    if (![fileManager fileExistsAtPath:dirApp]) {
        [fileManager createDirectoryAtPath:dirApp withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    dirApp = [dirApp stringByAppendingFormat:@"/%@",[[downloadTask response] suggestedFilename]];
    
    if ([fileManager fileExistsAtPath:dirApp]) {
        [fileManager removeItemAtPath:dirApp error:nil];
    }
    [fileManager moveItemAtPath:[location path] toPath:dirApp error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.getPath(dirApp, index);
        
    });
}

@end
