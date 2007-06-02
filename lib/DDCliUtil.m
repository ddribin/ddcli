//
//  DDCliUtil.m
//  ddcurl
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DDCliUtil.h"


void ddfprintf(FILE * stream, NSString * format, ...)
{
    va_list arguments;
    va_start(arguments, format);
    NSString * string = [[NSString alloc] initWithFormat: format
                                               arguments: arguments];
    va_end(arguments);
    
    fprintf(stream, "%s", [string UTF8String]);
    [string release];
}

void ddprintf(NSString * format, ...)
{
    va_list arguments;
    va_start(arguments, format);
    NSString * string = [[NSString alloc] initWithFormat: format
                                               arguments: arguments];
    va_end(arguments);
    
    printf("%s", [string UTF8String]);
    [string release];
}