/*
 * Copyright (c) 2007 Dave Dribin
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import <Cocoa/Cocoa.h>

@class DDCliApplication;
@class DDGetoptLongParser;

/**
 * Methods that the DDCliApplication delegate must implement.
 */
@protocol DDCliApplicationDelegate <NSObject>

/**
 * This is the main entry point of a command line application.  It is
 * called after options have been parsed, and the arguments passed in
 * have the options removed.
 *
 * @param app The corresponding application instance
 * @param arguments Command line arguments, post option parsing
 * @return The return value of the application
 */
- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;

/**
 * Called prior to option parsing so that options may added to the
 * options parser.
 *
 * @param app The corresponding application instance
 * @param options The options parser.
 */
- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLongParser *) options;

@end

/**
 * A class that represents a command line application.
 */
@interface DDCliApplication : NSObject
{
    @private
    NSString * mName;
}

/**
 * Returns the common shared application.
 *
 * @return The common shared application
 */
+ (DDCliApplication *) sharedApplication;

/**
 * Returns the name of this application.
 *
 * @return The name of this application
 */
- (NSString *) name;

/**
 * Returns the name of this application.  Coupled with the
 * #DDCliApp global, this makes it easy to print standard Unix-style
 * error messages:
 *
 * @code
 ddfprintf(stderr, "%@: An error occured", DDCliApp);
 * @endcode
 *
 * @return The application name
 */
- (NSString *) description;

/**
 * Runs a command line application with the specified delegate class,
 * and returns the result.  This instantiates an instance of the
 * delegate class, and releases it up completion.  Exceptions are
 * trapped, and an error message is printed.
 *
 * @param delegateClass The class of the delegate
 */
- (int) runWithClass: (Class) delegateClass;

@end

/**
 * @ingroup functions
 * @{
 */

/** The shared application. */
extern DDCliApplication * DDCliApp;

/**
 * Runs a command line application with the given delegate class.
 * This sets up an autorelease pool, and creates an instance of the
 * delegate class.
 *
 * @param delegateClass Class to instantiate for the delegate.
 */
int DDCliAppRunWithClass(Class delegateClass);

/** @} */

/**
 * @example simple.m
 *
 * This is a very simple example application.
 *
 * @include SimpleApp.h
 * @include SimpleApp.m
 */

/**
 * @example example.m
 *
 * This is a slighly more complexe example application.
 *
 * @include ExampleApp.h
 * @include ExampleApp.m
 */
