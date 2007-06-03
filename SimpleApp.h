#import "DDCommandLineInterface.h"

@interface SimpleApp : NSObject <DDCliApplicationDelegate>
{
    NSString * _output;
    BOOL _help;
}

@end
