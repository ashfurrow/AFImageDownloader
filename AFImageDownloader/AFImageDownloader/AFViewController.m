//
//  AFViewController.m
//  AFImageDownloader
//
//  Created by Ash Furrow on 2013-01-14.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFViewController.h"

#import "AFImageDownloader.h"

@interface AFViewController ()

@end

@implementation AFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [AFImageDownloader imageDownloaderWithURLString:@"http://static.ashfurrow.com.s3.amazonaws.com/github/worked.jpg" autoStart:YES completion:^(UIImage *decompressedImage) {
        self.imageView.image = decompressedImage;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
