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

-(NSURLRequest *)urlRequestForURLString;
-(NSURLConnection *)urlConnectionForURLRequest:(NSURLRequest *)request;

@end

SPEC_BEGIN(AFImageDownloaderStartingTests)

describe(@"Image downloader", ^{
    NSString *urlString = @"http://example.com/image.jpeg";
    __block AFImageDownloader *imageDownloader;
    
    context(@"has been newly created", ^{
        beforeEach(^{
            imageDownloader = [[AFImageDownloader alloc] initWithURLString:urlString autoStart:NO];
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
            NSURLConnection *urlConnectionMock = [NSURLConnection mock];
            [[urlConnectionMock should] receive:@selector(start)];
            
            [imageDownloader stub:@selector(urlConnectionForURLRequest:) andReturn:urlConnectionMock];
            
            [imageDownloader start];
        });
    });
});

SPEC_END


