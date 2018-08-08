//
//  HTMLParse.h
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLParse : NSObject

- (void) getArrayDataForUI:(void(^)(NSArray* resuly))complition;

@end
