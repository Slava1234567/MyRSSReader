//
//  CoreDataManager.h
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (strong, nonatomic) NSPersistentContainer *  persistentContainer;

+ (CoreDataManager*) shared;
- (void)saveContext;
- (NSArray*) getArrayObject:(NSString*) entityName withPredicate:(NSPredicate*) predicate And:(NSSortDescriptor*) sortDescriptor;

@end
