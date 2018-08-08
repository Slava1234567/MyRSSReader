//
//  Media+CoreDataProperties.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Media+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Media (CoreDataProperties)

+ (NSFetchRequest<Media *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *path;
@property (nonatomic) int32_t tag;
@property (nullable, nonatomic, retain) Data *data;

@end

NS_ASSUME_NONNULL_END
