//
//  Media+CoreDataProperties.m
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Media+CoreDataProperties.h"

@implementation Media (CoreDataProperties)

+ (NSFetchRequest<Media *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Media"];
}

@dynamic path;
@dynamic tag;
@dynamic data;

@end
