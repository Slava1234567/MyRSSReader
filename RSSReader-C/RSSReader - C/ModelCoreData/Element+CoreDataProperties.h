//
//  Element+CoreDataProperties.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Element+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Element (CoreDataProperties)

+ (NSFetchRequest<Element *> *)fetchRequest;

@property (nonatomic) int32_t tag;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Content *content;
@property (nullable, nonatomic, retain) NSSet<Data *> *data;

@end

@interface Element (CoreDataGeneratedAccessors)

- (void)addDataObject:(Data *)value;
- (void)removeDataObject:(Data *)value;
- (void)addData:(NSSet<Data *> *)values;
- (void)removeData:(NSSet<Data *> *)values;

@end

NS_ASSUME_NONNULL_END
