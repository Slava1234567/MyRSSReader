//
//  Content+CoreDataProperties.h
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Content+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Content (CoreDataProperties)

+ (NSFetchRequest<Content *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *mainTitle;
@property (nonatomic) int32_t tag;
@property (nullable, nonatomic, retain) NSSet<Element *> *element;

@end

@interface Content (CoreDataGeneratedAccessors)

- (void)addElementObject:(Element *)value;
- (void)removeElementObject:(Element *)value;
- (void)addElement:(NSSet<Element *> *)values;
- (void)removeElement:(NSSet<Element *> *)values;

@end

NS_ASSUME_NONNULL_END
