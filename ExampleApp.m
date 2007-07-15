#import "ExampleApp.h"


@implementation ExampleApp

- (id) init;
{
    self = [super init];
    if (self == nil)
        return nil;
    
    _includeDirectories = [[NSMutableArray alloc] init];
    
    return self;
}

- (void) setVerbose: (BOOL) verbose;
{
    if (verbose)
        _verbosity++;
    else if (_verbosity > 0)
        _verbosity--;
}

- (void) setInclude: (NSString *) file;
{
    if ([file isEqualToString: @"invalid"])
    {
        DDCliParseException * e =
            [DDCliParseException parseExceptionWithReason: @"Invalid name"
                                                 exitCode: 5];
        @throw e;
    }
    [_includeDirectories addObject: file];
}

- (void) printUsage: (FILE *) stream;
{
    ddfprintf(stream, @"%@: Usage [OPTIONS] <argument> [...]\n", DDCliApp);
}

- (void) printHelp;
{
    [self printUsage: stdout];
    printf("\n"
           "  -f, --foo FOO                 Use foo with FOO\n"
           "  -I, --include FILE            Include FILE\n"
           "  -b, --bar[=BAR]               Use bar with BAR\n"
           "      --long-opt                Enable long option\n"
           "  -v, --verbose                 Increase verbosity\n"
           "      --version                 Display version and exit\n"
           "  -h, --help                    Display this help and exit\n"
           "\n"
           "A test application for DDCommandLineInterface.\n");
}

- (void) printVersion;
{
    ddprintf(@"%@ version %s\n", DDCliApp, CURRENT_MARKETING_VERSION);
}

- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLongParser *) optionsParser;
{
    DDGetoptOption optionTable[] = 
    {
        // Long         Short   Argument options
        {@"foo",        'f',    DDGetoptRequiredArgument},
        {@"include",    'I',    DDGetoptRequiredArgument},
        {@"bar",        'b',    DDGetoptOptionalArgument},
        {@"long-opt",   0,      DDGetoptNoArgument},
        {@"verbose",    'v',    DDGetoptNoArgument},
        {@"version",    0,      DDGetoptNoArgument},
        {@"help",       'h',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable: optionTable];
}

- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;
{
    if (_help)
    {
        [self printHelp];
        return 0;
    }
    
    if (_version)
    {
        [self printVersion];
        return 0;
    }
    
    if ([arguments count] < 1)
    {
        ddfprintf(stderr, @"%@: At least one argument is required\n", DDCliApp);
        [self printUsage: stderr];
        ddfprintf(stderr, @"Try `%@ --help' for more information.\n",
                  DDCliApp);
        return 1;
    }
    
    ddprintf(@"foo: %@, bar: %@, longOpt: %@, verbosity: %d\n",
             _foo, _bar, _longOpt, _verbosity);
    ddprintf(@"Include directories: %@\n", _includeDirectories);
    ddprintf(@"Arguments: %@\n", arguments);
    return 0;
}

@end
