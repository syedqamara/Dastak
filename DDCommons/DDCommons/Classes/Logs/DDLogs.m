//
//  DDLogs.m
//  AFNetworking
//
//  Created by Awais Shahid on 18/06/2019.
//

#import "DDLogs.h"


@implementation DDLogs

+ (void)log:(NSString *)format, ...
 {
     va_list args;
     va_start(args, format);
     NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
     va_end(args);
    
    if (TRUE) { // Need to change this
        NSLog(@"%@", msg);
    }
}

@end
