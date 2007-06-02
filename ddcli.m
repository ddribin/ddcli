#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "TestApp.h"

int main (int argc, char * const * argv)
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int result = DDCliAppRunWithClass([TestApp class]);
    [pool release];
    return result;
}
