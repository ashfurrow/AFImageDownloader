//
//  AFImageDownloader.h
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFImageDownloader : NSObject

+(instancetype)imageDownloaderWithURLString:(NSString *)urlString;

-(id)initWithURLString:(NSString *)urlString;

@property (nonatomic, readonly, strong) NSString *urlString;

@end
