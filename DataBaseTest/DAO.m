//
//  DAO.m
//  DataBaseTest
//
//  Created by Maikol Araya on 11/30/13.
//  Copyright (c) 2013 La Creativeria. All rights reserved.
//

#import "DAO.h"

#define DATABASE_NAME @"TestDataBase.sqlite"
#define SELECT_ALL_EVENTS_QUERY "Select * from Eventos"

static sqlite3 *database = nil;
static DAO *sharedSingleton = nil;

@implementation DAO

- (DAO*) retrieveSingleton {
    @synchronized(self) {
        if (sharedSingleton == nil) {
            sharedSingleton = [[DAO alloc] init];
        }
    }
    return sharedSingleton;
}

-(id) init {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Error creating database: '%@'.", [error localizedDescription]);
    }
    return self;
}

-(NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingString:DATABASE_NAME];
}

-(NSMutableArray *) getEventsFromDataBase {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    const char *dbpath = [[self getDBPath] UTF8String];
    sqlite3_stmt *statement;
    statement = nil;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        const char *querySQL = SELECT_ALL_EVENTS_QUERY;
        
        if (sqlite3_prepare_v2(database, querySQL, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSMutableString *eventName = [[NSMutableString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                //NSLog(@"String: %@", eventName);
                [result addObject:eventName];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return result;
}








































@end
