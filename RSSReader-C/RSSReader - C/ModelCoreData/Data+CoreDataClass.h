//
//  Data+CoreDataClass.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Element, Media;

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Data+CoreDataProperties.h"
