//
//  AFImageDownloader.h
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AFImageDownloaderStateNotStarted,
    AFImageDownloaderStateStarted,
    AFImageDownloaderStateCompleted
}AFImageDownloaderState;

@interface AFImageDownloader : NSObject

#pragma mark - Convenience Class Creation Methods

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString;  // Defaults to not starting immediately
+(instancetype)imageDownloaderWithURLString:(NSString *)urlString autoStart:(BOOL)startImmediately;

#pragma mark - Initializer Methods

-(id)initWithURLString:(NSString *)urlString;  // Defaults to not starting immediately
-(id)initWithURLString:(NSString *)urlString autoStart:(BOOL)startImmediately; // Designated initializer

#pragma mark - Instance Methods

-(void)start;

#pragma mark - Properties

@property (nonatomic, readonly) NSString *urlString;
@property (nonatomic, readwrite) AFImageDownloaderState state;

@end
