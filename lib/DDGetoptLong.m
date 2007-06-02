//
//  DDGetoptLong.m
//  ddcurl
//
//  Created by Dave Dribin on 6/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DDGetoptLong.h"
#import "DDCliUtil.h"


@interface DDGetoptLong (Private)

- (NSString *) optionToKey: (NSString *) option;
- (struct option *) firstOption;
- (struct option *) currentOption;
- (void) addOption;

@end

@implementation DDGetoptLong

+ (DDGetoptLong *) optionsWithTarget: (id) target;
{
    return [[[self alloc] initWithTarget: target] autorelease];
}

- (id) initWithTarget: (id) target;
{
    self = [super init];
    if (self == nil)
        return nil;
    
    mTarget = target;
    // Non-single char options start after as the last ASCII character
    mNextShortOption = 256;
    mOptionsData = [[NSMutableData alloc] initWithLength: sizeof(struct option)];
    mCurrentOption = 0;
    mUtf8Data = [[NSMutableArray alloc] init];
    mOptionString = [[NSMutableString alloc] init];
    mOptionInfoMap = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void) addOptionsFromTable: (DDGetoptOption *) optionTable;
{
    DDGetoptOption * currentOption = optionTable;
    while ((currentOption->longOption != nil) ||
           (currentOption->shortOption != 0))
    {
        [self addLongOption: currentOption->longOption
                shortOption: currentOption->shortOption
                        key: [self optionToKey: currentOption->longOption]
            argumentOptions: currentOption->argumentOptions];
        currentOption++;
    }
}

- (void) addLongOption: (NSString *) longOption
           shortOption: (char) shortOption
                   key: (NSString *) key
       argumentOptions: (DDGetoptArgumentOptions) argumentOptions;
{
    const char * utf8String = [longOption UTF8String];
    NSData * utf8Data = [NSData dataWithBytes: utf8String length: strlen(utf8String)];
    
    struct option * option = [self currentOption];
    option->name = utf8String;
    option->has_arg = argumentOptions;
    option->flag = NULL;

    int shortOptionValue;
    if (shortOption != 0)
    {
        shortOptionValue = shortOption;
        option->val = shortOption;
        if (argumentOptions == DDGetoptRequiredArgument)
            [mOptionString appendFormat: @"%c:", shortOption];
        else if (argumentOptions == DDGetoptOptionalArgument)
            [mOptionString appendFormat: @"%c::", shortOption];
        else
            [mOptionString appendFormat: @"%c", shortOption];
    }
    else
    {
        shortOptionValue = mNextShortOption;
        mNextShortOption++;
        option->val = shortOptionValue;
    }
    [self addOption];
    
    NSArray * optionInfo = [NSArray arrayWithObjects:
        key, [NSNumber numberWithInt: argumentOptions], nil];
    [mOptionInfoMap setObject: optionInfo
                       forKey: [NSNumber numberWithInt: shortOptionValue]];
    
    [mUtf8Data addObject: utf8Data];
}

- (void) addLongOption: (NSString *) longOption
                   key: (NSString *) key
       argumentOptions: (DDGetoptArgumentOptions) argumentOptions;
{
    [self addLongOption: longOption shortOption: 0
                    key: key argumentOptions: argumentOptions];
}

- (NSArray *) processOptions;
{
    NSProcessInfo * processInfo = [NSProcessInfo processInfo];
    NSArray * arguments = [processInfo arguments];
    NSString * command = [processInfo processName];
    return [self processOptionsWithArguments: arguments command: command];
}

- (NSArray *) processOptionsWithArguments: (NSArray *) arguments
                                  command: (NSString *) command;
{
    int argc = [arguments count];
    char ** argv = alloca(sizeof(char *) * argc);
    int i;
    for (i = 0; i < argc; i++)
    {
        NSString * argument = [arguments objectAtIndex: i];
        argv[i] = (char *) [argument UTF8String];
    }
    
    // Make sure list is NULL terminated
    struct option * option = [self currentOption];
    option->name = NULL;
    option->has_arg = 0;
    option->flag = NULL;
    option->val = 0;
    
    const char * optionString = [mOptionString UTF8String];
    int ch;
    while ((ch = getopt_long(argc, argv, optionString, [self firstOption], NULL)) != -1)
    {
        NSString * nsoptarg = nil;
        if (optarg != NULL)
            nsoptarg = [NSString stringWithUTF8String: optarg];
        
        NSArray * optionInfo = [mOptionInfoMap objectForKey: [NSNumber numberWithInt: ch]];
        if (optionInfo != nil)
        {
            NSString * key = [optionInfo objectAtIndex: 0];
            int argumentOptions = [[optionInfo objectAtIndex: 1] intValue];
            if (argumentOptions == DDGetoptNoArgument)
                [mTarget setValue: [NSNumber numberWithBool: YES] forKey: key];
            else
                [mTarget setValue: nsoptarg forKey: key];
        }
        else
        {
            ddfprintf(stderr, @"Try `%@ --help` for more information.\n", command);
            return nil;
        }
    }
    
    NSRange range = NSMakeRange(optind, argc - optind);
    return [arguments subarrayWithRange: range];
}

@end

@implementation DDGetoptLong (Private)

- (NSString *) optionToKey: (NSString *) option;
{
    NSScanner * scanner = [NSScanner scannerWithString: option];
    [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString: @"-"]];
    NSMutableString * key = [NSMutableString string];
    NSString * string = nil;
    BOOL caps = NO;
    while ([scanner scanUpToString: @"-" intoString: &string])
    {
        if (caps)
            string = [string capitalizedString];
        [key appendString: string];
        caps = YES;
    }
    return key;
}

- (struct option *) firstOption;
{
    struct option * options = [mOptionsData mutableBytes];
    return options;
}

- (struct option *) currentOption;
{
    struct option * options = [mOptionsData mutableBytes];
    return &options[mCurrentOption];
}

- (void) addOption;
{
    [mOptionsData increaseLengthBy: sizeof(struct option)];
    mCurrentOption++;
}

@end

