//
//  Element+CoreDataClass.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Content, Data;

NS_ASSUME_NONNULL_BEGIN

@interface Element : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Element+CoreDataProperties.h"
