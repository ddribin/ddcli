//
//  DDCliParseException.h
//  ddcli
//
//  Created by Dave Dribin on 7/15/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * A option parsing exception. This should cause the program to
 * terminate with the given exit code.
 */
@interface DDCliParseException : NSException
{
    int mExitCode;
}

/**
 * Create a new exception with a given reason and exit code.
 *
 * @param reason Reason for the exception
 * @param exitCode Desired exit code
 * @return Autoreleased exception
 */
+ (DDCliParseException *) parseExceptionWithReason: (NSString *) reason
                                          exitCode: (int) exitCode;

/**
 * Create a new exception with a given reason and exit code.
 *
 * @param reason Reason for the exception
 * @param exitCode Desired exit code
 * @return New exception
 */
- (id) initWithReason: (NSString *) reason
             exitCode: (int) exitCode;

/**
 * Returns the desired exit code.
 *
 * @return The desired exit code
 */
- (int) exitCode;

@end
