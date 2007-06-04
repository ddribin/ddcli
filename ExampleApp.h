#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"

@interface ExampleApp : NSObject <DDCliApplicationDelegate>
{
    NSString * _foo;
    NSMutableArray * _includeFiles;
    NSString * _bar;
    NSString * _longOpt;
    int _verbosity;
    BOOL _version;
    BOOL _help;
}

@end

