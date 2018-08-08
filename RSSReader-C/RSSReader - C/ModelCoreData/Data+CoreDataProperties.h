//
//  Data+CoreDataProperties.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Data+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Data (CoreDataProperties)

+ (NSFetchRequest<Data *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *data;
@property (nullable, nonatomic, copy) NSString *descript;
@property (nullable, nonatomic, copy) NSString *link;
@property (nullable, nonatomic, copy) NSString *litleUrl;
@property (nullable, nonatomic, copy) NSString *path;
@property (nonatomic) int32_t tag;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Element *element;
@property (nullable, nonatomic, retain) NSSet<Media *> *media;

@end

@interface Data (CoreDataGeneratedAccessors)

- (void)addMediaObject:(Media *)value;
- (void)removeMediaObject:(Media *)value;
- (void)addMedia:(NSSet<Media *> *)values;
- (void)removeMedia:(NSSet<Media *> *)values;

@end

NS_ASSUME_NONNULL_END
