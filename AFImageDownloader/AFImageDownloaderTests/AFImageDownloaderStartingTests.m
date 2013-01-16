//
//  AFImageDownloaderStartingTests.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright 2013 Ash Furrow. All rights reserved.
//

#import "Kiwi.h"

#import "AFImageDownloader.h"

@interface AFImageDownloader (UnitTestAdditions)

-(void)setState:(AFImageDownloaderState)state;
-(NSURLRequest *)urlRequestForURLString;
-(NSURLConnection *)urlConnectionForURLRequest:(NSURLRequest *)request;

@end

SPEC_BEGIN(AFImageDownloaderStartingTests)

describe(@"Image downloader", ^{
    NSString *urlString = @"http://example.com/image.jpeg";
    __block AFImageDownloader *imageDownloader;
    
    context(@"has been newly created", ^{
        beforeEach(^{
            imageDownloader = [[AFImageDownloader alloc] initWithURLString:urlString autoStart:NO completion:nil];
        });
        
        it (@"should create a new URL connection when started", ^{
            [[imageDownloader should] receive:@selector(urlRequestForURLString)];
            [[imageDownloader should] receive:@selector(urlConnectionForURLRequest:)];
            [imageDownloader start];
        });
        
        it (@"should return a URL request with the proper URL string", ^{
            NSURLRequest *request = [imageDownloader urlRequestForURLString];
            
            [[request.URL.absoluteString should] equal:urlString];
        });
        
        it (@"should start the new URL connection", ^{
            
            [imageDownloader start];
        });
        
        it (@"should be set it state to started when started", ^{
            NSURLConnection *urlConnectionMock = [NSURLConnection mock];
            [[urlConnectionMock should] receive:@selector(start)];
            
            [imageDownloader stub:@selector(urlConnectionForURLRequest:) andReturn:urlConnectionMock];
            
            [[imageDownloader should] receive:@selector(setState:) withArguments:theValue(AFImageDownloaderStateStarted), nil];
            [imageDownloader start];
        });
    });
});

SPEC_END


