//
//  NetworkHelper.h
//  Search_Cell
//
//  Created by Вова on 10.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkRequest : NSObject 

+ (NSString *)URLForSearchString:(NSString *)searchString currentPage: (NSUInteger) currentpage;

@end

NS_ASSUME_NONNULL_END
