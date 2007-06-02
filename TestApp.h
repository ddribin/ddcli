//
//  TestApp.h
//  ddcli
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"

@interface TestApp : NSObject <DDCliApplicationDelegate>
{
    NSString * _foo;
    NSString * _bar;
    NSString * _longOpt;
    int _verbosity;
    BOOL _help;
}

@end

