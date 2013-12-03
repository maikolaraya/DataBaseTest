//
//  DAO.h
//  DataBaseTest
//
//  Created by Maikol Araya on 11/30/13.
//  Copyright (c) 2013 La Creativeria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DAO : NSObject

- (id) init;

- (DAO *) retrieveSingleton;

-(NSMutableArray*) getEventsFromDataBase;














@end






