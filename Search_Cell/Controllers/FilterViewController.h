//
//  FilterViewController.h
//  Search_Cell
//
//  Created by Вова on 16.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

-(instancetype) initWithImage: (UIImage *) image;

@end

NS_ASSUME_NONNULL_END
