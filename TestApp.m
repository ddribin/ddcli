//
//  TestApp.m
//  ddcli
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "TestApp.h"


@implementation TestApp

- (void) setVerbose: (BOOL) verbose;
{
    if (verbose)
        _verbosity++;
    else if (_verbosity > 0)
        _verbosity--;
}

- (void) printHelp;
{
    [self application: DDCliApp printUsage: stdout];
    printf("\n");
    printf("  -f, --foo=FOO                 Use foo with FOO\n");
    printf("  -b, --bar[=BAR]               Use bar with BAR\n");
    printf("      --long-opt                Enable long option\n");
    printf("  -v, --verbose                 Increase verbosity\n");
    printf("  -h, --help                    Display this help and exit\n");
    printf("\n");
    printf("A test application for DDCommandLineInterface.\n");
    printf("\n");
}

- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLong *) options;
{
    DDGetoptOption optionTable[] = 
    {
        // Long         Short   Argument options
        {@"foo",        'f',    DDGetoptRequiredArgument},
        {@"bar",        'b',    DDGetoptOptionalArgument},
        {@"long-opt",   0,      DDGetoptNoArgument},
        {@"verbose",    'v',    DDGetoptNoArgument},
        {@"help",       'h',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [options addOptionsFromTable: optionTable];
}

- (void) application: (DDCliApplication *) app
          printUsage: (FILE *) stream;
{
    ddfprintf(stderr, @"%@: Usage [OPTIONS] <arguments> ...\n", [app name]);
}

- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;
{
    if (_help)
    {
        [self printHelp];
        return 0;
    }
    
    ddprintf(@"foo: %@, bar: %@, longOpt: %@, verbosity: %d\n",
             _foo, _bar, _longOpt, _verbosity);
    ddprintf(@"Arguments: %@\n", arguments);
    return 0;
}

@end
