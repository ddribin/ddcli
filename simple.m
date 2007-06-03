#import "DDCommandLineInterface.h"
#import "SimpleApp.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([SimpleApp class]);
}
