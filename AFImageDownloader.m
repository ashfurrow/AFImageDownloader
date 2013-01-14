//
//  AFImageDownloader.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFImageDownloader.h"

@interface AFImageDownloader () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *mutableData;

@end

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

-(NSURLConnection *)urlConnectionForURLRequest:(NSURLRequest *)request
{
    return [NSURLConnection connectionWithRequest:request delegate:self];
}

-(NSURLRequest *)urlRequestForURLString
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
}

#pragma mark - Public Methods

-(void)start
{
    NSURLRequest *urlRequest = [self urlRequestForURLString];
    self.connection = [self urlConnectionForURLRequest:urlRequest];
    self.mutableData = [NSMutableData data];
    [self.connection start];
    
    [self willChangeValueForKey:@"state"];
    _state = AFImageDownloaderStateStarted;
    [self didChangeValueForKey:@"state"];
}

-(void)cancel
{
    [self.connection cancel];
    
    [self willChangeValueForKey:@"state"];
    _state = AFImageDownloaderStateCompleted;
    [self didChangeValueForKey:@"state"];
}

#pragma mark - NSURLConnectionDataDelegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

@end
