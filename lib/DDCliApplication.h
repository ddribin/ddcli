//
//  DDCliApplication.h
//  ddcurl
//
//  Created by Dave Dribin on 6/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DDCliApplication;
@class DDGetoptLong;

@protocol DDCliApplicationDelegate <NSObject>

- (void) application: (DDCliApplication *) app
          printUsage: (FILE *) stream;

- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;

- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLong *) options;

@end


@interface DDCliApplication : NSObject
{
    NSString * mName;
}

+ (DDCliApplication *) sharedApplication;

- (NSString *) name;

- (int) runWithClass: (Class) delegateClass;

@end

extern DDCliApplication * DDCliApp;

int DDCliAppRunWithClass(Class delegateClass);
