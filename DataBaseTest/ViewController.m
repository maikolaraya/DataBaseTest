//
//  ViewController.m
//  DataBaseTest
//
//  Created by Maikol Araya on 11/30/13.
//  Copyright (c) 2013 La Creativeria. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
// Invocar la base de datos
    dataBase = [[DAO alloc] retrieveSingleton];
// Consultar los eventos
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    newArray = [dataBase getEventsFromDataBase];
    
    NSLog(@"evento: %@", [newArray objectAtIndex:0]);
// Imprimimos en consola
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
