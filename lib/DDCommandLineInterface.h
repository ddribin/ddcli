//
//  DDCommandLineInterface.h
//  ddcurl
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

/**
 * @mainpage ddcli: A Objective-C command line helper.
 *
 * ddcli is an Objective-C library to help write command line
 * applications.  It simplifies processing command line options and
 * eliminates much of the boiler plate code.  The getopt_long(3)
 * function is used to process command options.  Key-Value Coding
 * (KVC) is used to set the options on a target class.  The long
 * option is used as the key.  The value is either YES for options
 * that do not take an argument, or a string for options that do.
 *
 * The main class is DDCliApplication.  You customize it's behavior by
 * creating a class that implements the DDCliApplicationDelegate
 * protocol.  This protocol has two methods that must be implemented:
 *
 * @include appDelegate.m
 *
 * The first method allows the delegate to add options to the parser.
 * The second method is the main entry point to the command line
 * applications.  The simplest way to add options is to use the
 * DDGetoptLong.addOptionsFromTable: method:
 *
 * @include willParseOptions.m
 *
 * As options are parsed your delegate is also used as the target of
 * KVC modifiers.  The long option is used as the key to the
 * setValue:forKey: call.  The value is a boolean YES for options that
 * take no arguments or a string for options that do.  The simplest
 * way to handle this is to use instance variables with the same name
 * as the long options:
 *
 * @include SimpleApp.h
 *
 * After options are parsed, the entry point is called, assuming there
 * were no invalid options.  This implementation just prints the
 * arguments, and exits:
 *
 * @include runWithArguments.m
 * 
 * The final part that needs implementing is the main function.  The
 * #DDCliAppRunWithClass function makes this a one liner:
 *
 * @include simple.m
 *
 * Here is a sample run from this program:
 *
 * @verbatim
% simple -o output.txt the quick "brown fox"
Output: output.txt, help: 0
Arguments: (the, quick, "brown fox")
@endverbatim
 *
 * The full source for this simple application can be found on @link
 * SimpleApp @endlink.  See @link ExampleApp @endlink for a more
 * complex example.
 *
 */

/**
 * @defgroup functions Functions and global variables
 * @defgroup enum Enumerations
 */

#import <Foundation/Foundation.h>

#import "DDGetoptLong.h"
#import "DDCliApplication.h"
#import "DDCliUtil.h"
