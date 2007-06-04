//
//  DDGetoptLong.h
//  ddcurl
//
//  Created by Dave Dribin on 6/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <getopt.h>
#import <libgen.h>

/**
 * Argument options.
 * @ingroup constants
 */
typedef enum DDGetoptArgumentOptions
{
    /** Option takes no argument */
    DDGetoptNoArgument = no_argument,
    /** Option takes an optional argument */
    DDGetoptOptionalArgument = optional_argument,
    /** Option takes a mandatory argument */
    DDGetoptRequiredArgument = required_argument,
} DDGetoptArgumentOptions;

/**
 * Structure to use for option tables.
 */
typedef struct
{
    /**
     * The long option without the double dash, "--".  This is required.
     */
    NSString * longOption;
    /** A single character for the short option.  Maybe be null or 0. */
    int shortOption;
    /** Argument options for this option. */
    DDGetoptArgumentOptions argumentOptions;
} DDGetoptOption;

/**
 * An Objective-C interface to getopt_long(3).  In order to simplify
 * usage, this class drives the option parsing by running the while
 * loop.  When an option is found, Key-Value Coding (KVC) is used to
 * set a key on the target class.  Unless overridden, the key to use
 * is the same as the long option.  The long option is converted to
 * camel case, if needed.  For example the option "long-option" has a
 * default key of "longOption".
 */
@interface DDGetoptLongParser : NSObject
{
    @private
    id mTarget;
    int mNextShortOption;
    NSMutableString * mOptionString;
    NSMutableDictionary * mOptionInfoMap;
    NSMutableData * mOptionsData;
    int mCurrentOption;
    NSMutableArray * mUtf8Data;
}

/**
 * Create an autoreleased option parser with the given target.
 *
 * @param target Object that receives target messages.
 */
+ (DDGetoptLongParser *) optionsWithTarget: (id) target;

/**
 * Create an option parser with the given target.
 *
 * @param target Object that receives target messages.
 */
- (id) initWithTarget: (id) target;

/**
 * Add all options from a null terminated option table.  The final
 * entry in the table should contain a nil long option and a null
 * short option.
 *
 * @param optionTable An array of DDGetoptOption.
 */
- (void) addOptionsFromTable: (DDGetoptOption *) optionTable;

/**
 * Add an option with both long and short options.  The long option
 * should not contain the double dash ('--').  If you do not want a
 * short option, set it to the zero or the null character.
 *
 * @param longOption The long option
 * @param shortOption The short option
 * @param key The key use when the option is parsed
 * @param argumentOptions Options for this options argument
 */
- (void) addLongOption: (NSString *) longOption
           shortOption: (char) shortOption
                   key: (NSString *) key
       argumentOptions: (DDGetoptArgumentOptions) argumentOptions;

/**
 * Add an option with no short option.
 *
 * @param longOption The long option
 * @param key The key use when the option is parsed
 * @param argumentOptions Options for this options argument
 */
- (void) addLongOption: (NSString *) longOption
                   key: (NSString *) key
       argumentOptions: (DDGetoptArgumentOptions) argumentOptions;

/**
 * Parse the options using the arguments and command name from
 * NSProcessInfo.
 *
 * @return Arguments left over after option parsing or <code>nil</code>
 */
- (NSArray *) parseOptions;

/**
 * Parse the options on an array of arguments.
 *
 * @param arguments Array of command line arguments
 * @param command Command name to use for error messages.
 * @return Arguments left over after option processing or <code>nil</code>
 */
- (NSArray *) parseOptionsWithArguments: (NSArray *) arguments
                                command: (NSString *) command;

@end

/**
 * DDGetoptLong delegate methods.
 */
@interface NSObject (DDGetoptLong)

/**
 * Called if an option that is not recognized is found.  If this is
 * not implemented, then a default error message is printed.  For long
 * options, the option includes the two dashes. For short options, the
 * option is just a single character.
 *
 * @param option The option that was not recognized.
 */
- (void) optionIsNotRecognized: (NSString *) option;

/**
 * Called if an argument was not supplied for option that is required
 * to have an argument.  If this is not implemented then a defeault
 * error message is printed.  For long options, the option includes
 * the two dashes. For short options, the option is just a single
 * character.
 *
 * @param option The option that had the missiong argument.
 */
- (void) optionIsMissingArgument: (NSString *) option;

@end
