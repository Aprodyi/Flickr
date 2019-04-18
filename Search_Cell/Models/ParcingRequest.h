//
//  NetworkService.h
//  Search_Cell
//
//  Created by Вова on 10.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelegateNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParcingRequest : NSObject

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output;

//currentPage необходимо для реализации пагинации
- (void)findFlickrPhotoWithSearchString:(NSString *)searchSrting currentPage: (NSUInteger) currentpage;

@end

NS_ASSUME_NONNULL_END
