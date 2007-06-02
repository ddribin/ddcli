//
//  DDCliApplication.m
//  ddcurl
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DDCliApplication.h"
#import "DDGetoptLong.h"
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

        DDGetoptLong * options = [DDGetoptLong optionsWithTarget: delegate];
        [delegate application: self willParseOptions: options];
        NSArray * arguments = [options processOptions];
        if (arguments == nil)
        {
            [delegate application: self printUsage: stderr];
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

@end

int DDCliAppRunWithClass(Class delegateClass)
{
    return [[DDCliApplication sharedApplication] runWithClass: delegateClass];
}
