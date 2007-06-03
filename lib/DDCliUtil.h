//
//  DDCliUtil.h
//  ddcurl
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @ingroup functions
 * @{
 */

/**
 * Like printf, but with Objective-C formatting.
 *
 * @param format String format specification
 */
void ddprintf(NSString * format, ...);

/**
 * Like fprintf, but with Objective-C formatting.
 *
 * @param stream Standard I/O stream
 * @param format String format specification
 */
void ddfprintf(FILE * stream, NSString * format, ...);

/** @} */
