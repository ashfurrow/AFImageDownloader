# AFImageDownloader
A simple image downloader for iOS. 

Downloads JPEG images asynchronously and decompresses them on a background thread.

## TODOs

1. Needs to retain self somehow.
2. Needs to cancel on failed responses.
3. Needs to turn JPEG into UIImage in background thread.
4. Needs to abstract `setState:`.
5. Needs to set `connection` and `mutableData` to `nil` when being cancelled.

