//
//  Controller.h
//  Search_Cell
//
//  Created by Вова on 07.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController

- (instancetype)initWithSeachString: (NSString *) searchString;
- (void)searchPushNotification;
- (void)sheduleLocalNotification;

@end

NS_ASSUME_NONNULL_END
