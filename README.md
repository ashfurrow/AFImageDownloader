## AFImageDownloader
A simple image downloader for iOS. Still working on completing it. It's a personal side project and challenge I'm working on: can I develop a small library that will fetch and decompress JPEGs efficiently completely using Behaviour-Driven Development with [Kiwi](https://github.com/allending/Kiwi)? I didn't let the app touch the Internet until it was completely done. The first time I ran it, it worked.

Downloads JPEG images asynchronously and decompresses them on a background thread.

## Usage

Import the following four files into your project. `#import` the `AFImageDownloader.h` file and you're good to go!

- `AFImageDownloader.h`
- `AFImageDownloader.m`
- `NSData+AFDecompression.h`
- `NSData+AFDecompression.m`

Usage is pretty simple:

    [AFImageDownloader imageDownloaderWithURLString:@"http://static.ashfurrow.com.s3.amazonaws.com/github/worked.jpg" autoStart:YES completion:^(UIImage *decompressedImage) {
        self.imageView.image = decompressedImage;
    }];

It's a "fire and forget" class, so you don't need to worry about retaining a strong reference to it. It will deallocate its own memory when its completed or cancelled.

## Testing

Make sure to do a recursive checkout to get the [Kiwi](https://github.com/allending/Kiwi) testing frameworking.

    git checkout --recursive git://github.com/AshFurrow/AFImageDownloader.git
