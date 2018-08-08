//
//  Element+CoreDataProperties.m
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Element+CoreDataProperties.h"

@implementation Element (CoreDataProperties)

+ (NSFetchRequest<Element *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Element"];
}

@dynamic tag;
@dynamic title;
@dynamic url;
@dynamic content;
@dynamic data;

@end
