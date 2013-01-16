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
@property (nonatomic, strong) AFJPEGWasDecompressedCallback completion;

@end

@implementation AFImageDownloader

static NSMutableSet *activeImageDownloadRequests;

#pragma mark - Class Methods

+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activeImageDownloadRequests = [NSMutableSet new];
    });
}

#pragma mark Creation Methods

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString completion:(AFJPEGWasDecompressedCallback)completion
{
    return [self imageDownloaderWithURLString:urlString autoStart:NO completion:completion];
}

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString autoStart:(BOOL)startImmediately completion:(AFJPEGWasDecompressedCallback)completion
{
    return [[AFImageDownloader alloc] initWithURLString:urlString autoStart:startImmediately completion:completion];
}

#pragma mark - Initializers

-(id)initWithURLString:(NSString *)urlString autoStart:(BOOL)startImmediately completion:(AFJPEGWasDecompressedCallback)completion
{
    if (!(self = [super init])) return nil;
    
    _urlString = urlString;
    _state = AFImageDownloaderStateNotStarted;
    _completion = [completion copy];
    
    if (startImmediately)
    {
        [self start];
    }
    
    return self;
}

-(id)initWithURLString:(NSString *)urlString completion:(AFJPEGWasDecompressedCallback)completion
{
    return [self initWithURLString:urlString autoStart:NO completion:completion];
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

-(void)addSelfToActiveRequestsSet
{
    [activeImageDownloadRequests addObject:self];
}

-(void)removeSelfFromActiveRequestsSet
{
    [activeImageDownloadRequests removeObject:self];
}

-(void)setState:(AFImageDownloaderState)state
{
    [self willChangeValueForKey:@"state"];
    _state = state;
    [self didChangeValueForKey:@"state"];
    
    if (state == AFImageDownloaderStateStarted)
    {
        [self addSelfToActiveRequestsSet];
    }
    else if (state == AFImageDownloaderStateCompleted)
    {
        [self removeSelfFromActiveRequestsSet];
        
        self.mutableData = nil;
        self.connection = nil;
    }
}

#pragma mark - Public Methods

-(void)start
{
    NSURLRequest *urlRequest = [self urlRequestForURLString];
    self.connection = [self urlConnectionForURLRequest:urlRequest];
    self.mutableData = [NSMutableData data];
    [self.connection start];
    
    [self setState:AFImageDownloaderStateStarted];
}

-(void)cancel
{
    [self.connection cancel];
    
    [self setState:AFImageDownloaderStateCompleted];
}

#pragma mark - NSURLConnectionDataDelegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection != self.connection) return;
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSUInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (statusCode != 200)
        {
            [self cancel];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == self.connection)
    {
        [self.mutableData appendData:data];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == self.connection)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.mutableData af_decompressedImageFromJPEGDataWithCallback:self.completion];
            [self setState:AFImageDownloaderStateCompleted];
        });
    }
}

@end
