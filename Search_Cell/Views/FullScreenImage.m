//
//  FilterImage.m
//  Search_Cell
//
//  Created by Вова on 16.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "FullScreenImage.h"
#import "FilterViewController.h"

@interface FullScreenImage ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) BOOL rightBarButtonItemFlag;

@end

@implementation FullScreenImage

-(instancetype) initWithImage: (UIImage *) image andFlag: (BOOL) flag
{
    if (self = [super init])
    {
        _image = image;
        _rightBarButtonItemFlag = flag;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame: self.view.frame];
    [self.imageView setImage: self.image];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview: self.imageView];
    
    if (self.rightBarButtonItemFlag)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Фильтры" style:UIBarButtonItemStyleDone target:self action:@selector(filterImage)];
    }
}

-(void) filterImage
{
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithImage: self.image];
    [self.navigationController pushViewController: filterViewController animated: YES];
}

@end
