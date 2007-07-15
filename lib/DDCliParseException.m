//
//  DDCliParseException.m
//  ddcli
//
//  Created by Dave Dribin on 7/15/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DDCliParseException.h"


@implementation DDCliParseException

+ (DDCliParseException *) parseExceptionWithReason: (NSString *) reason
                                          exitCode: (int) exitCode;
{
    return [[[self alloc] initWithReason: reason
                                exitCode: exitCode] autorelease];
}

- (id) initWithReason: (NSString *) reason
             exitCode: (int) exitCode;
{
    self = [super initWithName: NSStringFromClass([self class])
                        reason: reason
                      userInfo: nil];
    mExitCode = exitCode;
    return self;
}

- (int) exitCode;
{
    return mExitCode;
}

@end
