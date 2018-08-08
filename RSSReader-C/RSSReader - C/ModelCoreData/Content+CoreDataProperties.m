//
//  Content+CoreDataProperties.m
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Content+CoreDataProperties.h"

@implementation Content (CoreDataProperties)

+ (NSFetchRequest<Content *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Content"];
}

@dynamic mainTitle;
@dynamic tag;
@dynamic element;

@end
