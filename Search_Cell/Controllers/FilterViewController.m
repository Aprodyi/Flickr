//
//  FilterViewController.m
//  Search_Cell
//
//  Created by Вова on 16.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "FilterViewController.h"
#import "FullScreenImage.h"

@interface FilterViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *effectArray;
@property (nonatomic, strong) NSString *effectString;
@property (nonatomic, strong) UIImage *inputimage;
@property (nonatomic, strong) FullScreenImage *fullScreenImage;

@end


@implementation FilterViewController

-(instancetype) initWithImage: (UIImage *) image
{
    if (self = [super init])
    {
        _inputimage = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Фильтры";
    self.effectArray=[[NSMutableArray alloc] initWithObjects:@"Сепия", @"Виньетка", @"Нуар", @"Монохромно", @"Размытие", nil];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.dataSource = self;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Table View Cell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.effectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Table View Cell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Table View Cell"];
    cell.textLabel.text = [self.effectArray objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor brownColor];
    [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.contentView.layer setBorderWidth:0.3f];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.effectString = cell.textLabel.text;
    NSInteger item = [self.effectArray indexOfObject: self.effectString];
    
    CIContext *imageContext = [CIContext contextWithOptions:nil];
    CIImage *image = [[CIImage alloc] initWithImage: self.inputimage];
    CIFilter *filter;
    
    switch (item)
    {
            
        case 0: // Сепия
        {
            filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, image, @"inputIntensity", @1, nil];
            break;
        }
            
        case 1: // Виньетка
        {
            filter = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey, image,@"inputIntensity", @2.5, @"inputRadius", @15, nil];
            break;
        }
            
        case 2: // Нуар
        {
            filter = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: kCIInputImageKey,image, nil];
            break;
        }
            
        case 3: // Монохромно
        {
            filter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: kCIInputImageKey,image,@"inputColor",[CIColor colorWithRed:0.5 green:0.5 blue:1.0],@"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
            break;
        }
            
        case 4: // Размытие
        {
            filter = [CIFilter filterWithName:@"CIDiscBlur" keysAndValues: kCIInputImageKey, image, @"inputRadius", @5, nil];
        }
  
        default:
            break;
    }
    
    CIImage *result = [filter outputImage];
    CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
    UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
    self.fullScreenImage = [[FullScreenImage alloc] initWithImage: targetImage andFlag: NO];
    [self.navigationController pushViewController: self.fullScreenImage animated:YES];
}

@end
