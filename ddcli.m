#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "TestApp.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([TestApp class]);
}
