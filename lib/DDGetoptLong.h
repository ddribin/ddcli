//
//  DDGetoptLong.h
//  ddcurl
//
//  Created by Dave Dribin on 6/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <getopt.h>
#import <libgen.h>

typedef enum
{
    DDGetoptNoArgument = no_argument,
    DDGetoptOptionalArgument = optional_argument,
    DDGetoptRequiredArgument = required_argument,
} DDGetoptArgumentOptions;

typedef struct
{
    NSString * longOption;
    int shortOption;
    DDGetoptArgumentOptions argumentOptions;
} DDGetoptOption;

@interface DDGetoptLong : NSObject
{
    id mTarget;
    int mNextShortOption;
    NSMutableString * mOptionString;
    NSMutableDictionary * mOptionInfoMap;
    NSMutableData * mOptionsData;
    int mCurrentOption;
    NSMutableArray * mUtf8Data;
}

+ (DDGetoptLong *) optionsWithTarget: (id) target;

- (id) initWithTarget: (id) target;

- (void) addOptionsFromTable: (DDGetoptOption *) optionTable;

- (void) addLongOption: (NSString *) longOption
           shortOption: (char) shortOption
                   key: (NSString *) key
       argumentOptions: (DDGetoptArgumentOptions) argumentOptions;

- (void) addLongOption: (NSString *) longOption
                   key: (NSString *) key
       argumentOptions: (DDGetoptArgumentOptions) argumentOptions;

- (NSArray *) processOptions;

- (NSArray *) processOptionsWithArguments: (NSArray *) arguments
                                  command: (NSString *) command;

@end
