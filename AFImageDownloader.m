//
//  AFImageDownloader.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFImageDownloader.h"

@implementation AFImageDownloader

#pragma mark - Class Creation Methods

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString
{
    return [self imageDownloaderWithURLString:urlString autoStart:NO];
}

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString autoStart:(BOOL)startImmediately
{
    return [[AFImageDownloader alloc] initWithURLString:urlString autoStart:startImmediately];
}

#pragma mark - Initializers

-(id)initWithURLString:(NSString *)urlString autoStart:(BOOL)startImmediately
{
    if (!(self = [super init])) return nil;
    
    _urlString = urlString;
    _state = AFImageDownloaderStateNotStarted;
    
    if (startImmediately)
    {
        [self start];
    }
    
    return self;
}

-(id)initWithURLString:(NSString *)urlString
{
    return [self initWithURLString:urlString autoStart:NO];
}

#pragma mark - Private Helper Methods
-(void)start
{
    [self willChangeValueForKey:@"state"];
    _state = AFImageDownloaderStateStarted;
    [self didChangeValueForKey:@"state"];
}

@end
