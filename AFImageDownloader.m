//
//  AFImageDownloader.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFImageDownloader.h"

@implementation AFImageDownloader

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString
{
    return [[AFImageDownloader alloc] initWithURLString:urlString];
}

-(id)initWithURLString:(NSString *)urlString
{
    if (!(self = [super init])) return nil;
    
    _urlString = urlString;
    
    return self;
}

@end
