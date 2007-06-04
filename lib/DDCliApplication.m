//
//  DDCliApplication.m
//  ddcurl
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DDCliApplication.h"
#import "DDGetoptLongParser.h"
#import "DDCliUtil.h"

DDCliApplication * DDCliApp = nil;

@implementation DDCliApplication

+ (DDCliApplication *) sharedApplication;
{
    if (DDCliApp == nil)
        DDCliApp = [[DDCliApplication alloc] init];
    return DDCliApp;
}

- (id) init;
{
    self = [super init];
    if (self == nil)
        return nil;
    
    NSProcessInfo * processInfo = [NSProcessInfo processInfo];
    mName = [[processInfo processName] retain];
    
    return self;
}

- (NSString *) name;
{
    return mName;
}

- (int) runWithClass: (Class) delegateClass;
{
    NSObject<DDCliApplicationDelegate> * delegate = nil;
    int result = 0;
    @try
    {
        delegate = [[delegateClass alloc] init];

        DDGetoptLongParser * optionsParser =
            [DDGetoptLongParser optionsWithTarget: delegate];
        [delegate application: self willParseOptions: optionsParser];
        NSArray * arguments = [optionsParser parseOptions];
        if (arguments == nil)
        {
            return 1;
        }

        result = [delegate application: self
                      runWithArguments: arguments];
    }
    @catch (NSException * e)
    {
        ddfprintf(stderr, @"Caught: %@: %@\n", [e name], [e description]);
        result = 2;
    }
    @finally
    {
        if (delegate != nil)
        {
            [delegate release];
            delegate = nil;
        }
    }
    
    return result;
}

- (NSString *) description;
{
    return [self name];
}

@end

int DDCliAppRunWithClass(Class delegateClass)
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    // Initialize singleton/global
    DDCliApplication * app = [DDCliApplication sharedApplication];
    int result = [app runWithClass: delegateClass];
    [pool release];
    return result;
}
