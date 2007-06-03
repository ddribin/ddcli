#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "ExampleApp.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([ExampleApp class]);
}
