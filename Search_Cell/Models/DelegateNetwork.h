//
//  DelegateNetwork.h
//  Search_Cell
//
//  Created by Вова on 13.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkServiceOutputProtocol

@optional

- (void)loadingIsDoneWithDataRecieved:(NSMutableArray *)dataRecieved totalPagesAmount: (NSUInteger) totalPagesAmount;

@end
