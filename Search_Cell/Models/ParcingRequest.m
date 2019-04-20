//
//  NetworkService.m
//  Search_Cell
//
//  Created by Вова on 10.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "ParcingRequest.h"
#import "NetworkRequest.h"

@interface ParcingRequest ()

@property (nonatomic, strong) NSMutableArray *photoData;
@property (nonatomic, assign) NSUInteger pagesAmount;

@end

@implementation ParcingRequest

- (void)findFlickrPhotoWithSearchString:(NSString *)searchSrting currentPage: (NSUInteger) currentpage
{
    NSString *urlString = [NetworkRequest URLForSearchString:searchSrting currentPage: currentpage];
    NSLog(@"URL - %@", urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:150];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *photoDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"Page - %@", [photoDictionary valueForKeyPath:@"photos.page"]);
        NSUInteger pagesCount = [[photoDictionary valueForKeyPath:@"photos.pages"] intValue];
        self.photoData = [NSMutableArray new];
        for (int i=0; i<5; i++)
        {
            NSString *str = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", [photoDictionary valueForKeyPath:@"photos.photo.farm"][i], [photoDictionary valueForKeyPath:@"photos.photo.server"][i], [photoDictionary valueForKeyPath:@"photos.photo.id"][i], [photoDictionary valueForKeyPath:@"photos.photo.secret"][i]];
            NSURL *url = [NSURL URLWithString:str];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
            [self.photoData addObject:imageData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingIsDoneWithDataRecieved:self.photoData totalPagesAmount:pagesCount];
        });
    }];
    [sessionDataTask resume];
}

@end
