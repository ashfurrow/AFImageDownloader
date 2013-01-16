//
//  NewKiwiSpec.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-16.
//  Copyright 2013 Ash Furrow. All rights reserved.
//

#import "Kiwi.h"

#import "AFImageDownloader.h"

@interface AFImageDownloader (UnitTestAdditions)

-(void)removeSelfFromActiveRequestsSet;
-(void)addSelfToActiveRequestsSet;
-(void)setConnection:(NSURLConnection *)connection;

@end

SPEC_BEGIN(AFImageDownloaderStateChangeTests)


describe(@"Image Downloader", ^{
    NSString *urlString = @"http://example.com/image.jpeg";
    __block AFImageDownloader *imageDownloader;
    
    context(@"when newly created", ^{
        
        beforeEach(^{
            imageDownloader = [AFImageDownloader imageDownloaderWithURLString:urlString];
            NSURLConnection *urlConnectionMock = [NSURLConnection nullMock]; // A mock to avoid actually fetching from the Internet
            [imageDownloader setConnection:urlConnectionMock];
        });
        
        it (@"should change state when started", ^{
            [[imageDownloader should] receive:@selector(setState:)];
            
            [imageDownloader start];
        });
        
        it (@"should change state when cancelled", ^{
            [[imageDownloader should] receive:@selector(setState:)];
            
            [imageDownloader cancel];
        });
        
        it (@"should post key-value observation messages when state changes", ^{
            [[imageDownloader should] receive:@selector(willChangeValueForKey:) withArguments:@"state", nil];
            [[imageDownloader should] receive:@selector(didChangeValueForKey:) withArguments:@"state", nil];
            
            [imageDownloader setState:AFImageDownloaderStateCompleted];
        });
        
        it (@"should add itself to the shared cache when started", ^{
            [[imageDownloader should] receive:@selector(addSelfToActiveRequestsSet)];
            [imageDownloader setState:AFImageDownloaderStateStarted];
        });
        
        it (@"should remove itself from the shared cache when completed", ^{
            [[imageDownloader should] receive:@selector(removeSelfFromActiveRequestsSet)];
            [imageDownloader setState:AFImageDownloaderStateCompleted];
        });
    });
});

SPEC_END


