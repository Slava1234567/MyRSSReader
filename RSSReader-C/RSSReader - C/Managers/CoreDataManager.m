//
//  CoreDataManager.m
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "CoreDataManager.h"


@implementation CoreDataManager

+ (CoreDataManager*) shared {
    
    static CoreDataManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CoreDataManager alloc] init];
    });
    return manager;
}

- (NSArray*) getArrayObject:(NSString*) entityName withPredicate:(NSPredicate*) predicate And:(NSSortDescriptor*) sortDescriptor; {
    
        NSEntityDescription* entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.persistentContainer.viewContext];
        NSFetchRequest* fetctRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
        [fetctRequest setEntity:entityDescription];
        [fetctRequest setPredicate:predicate];
        [fetctRequest setSortDescriptors:@[sortDescriptor]];
        NSArray* arrayObjects = [self.persistentContainer.viewContext executeFetchRequest:fetctRequest error:nil];
        
    return  arrayObjects;
}


#pragma mark - Core Data stack

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"RSSReader___C"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
