//
//  NetworkHelper.m
//  Search_Cell
//
//  Created by Вова on 10.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

+ (NSString *)URLForSearchString:(NSString *)searchString currentPage: (NSUInteger) currentpage
{
    NSString *APIKey = @"478a1c5c1b45280df28edf1f08100976";
    
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=10&page=%lu&format=json&nojsoncallback=1", APIKey, searchString, currentpage];
}

@end
