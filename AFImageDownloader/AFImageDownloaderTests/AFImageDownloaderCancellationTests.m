//
//  AFImageDownloaderSCancellationTests.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright 2013 Ash Furrow. All rights reserved.
//

#import "Kiwi.h"

#import "AFImageDownloader.h"

@interface AFImageDownloader (UnitTestAdditions)

-(void)setConnection:(NSURLConnection *)connection;

@end

SPEC_BEGIN(AFImageDownloaderCancellationTests)

describe(@"Image downloader", ^{
    NSString *urlString = @"http://example.com/image.jpeg";
    __block AFImageDownloader *imageDownloader;
    
    context(@"has been newly created", ^{
        beforeEach(^{
            imageDownloader = [[AFImageDownloader alloc] initWithURLString:urlString autoStart:NO];
        });
        
        it (@"should call cancel on its URL Connection", ^{
            NSURLConnection *urlConnectionMock = [NSURLConnection mock];
            [[urlConnectionMock should] receive:@selector(cancel)];
            [imageDownloader setConnection:urlConnectionMock];
            
            [imageDownloader cancel];
            
            [[theValue(imageDownloader.state) should] equal:@(AFImageDownloaderStateCompleted)];
        });
    });
});

SPEC_END
