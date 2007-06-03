#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"

@interface ExampleApp : NSObject <DDCliApplicationDelegate>
{
    NSString * _foo;
    NSString * _bar;
    NSString * _longOpt;
    int _verbosity;
    BOOL _help;
}

@end

