//
//  Data+CoreDataProperties.m
//  RSSReader - C
//
//  Created by Slava on 8/3/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Data+CoreDataProperties.h"

@implementation Data (CoreDataProperties)

+ (NSFetchRequest<Data *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Data"];
}

@dynamic data;
@dynamic descript;
@dynamic link;
@dynamic litleUrl;
@dynamic path;
@dynamic tag;
@dynamic title;
@dynamic url;
@dynamic element;
@dynamic media;

@end
