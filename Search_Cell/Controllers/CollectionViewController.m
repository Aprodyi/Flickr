//
//  Controller.m
//  Search_Cell
//
//  Created by Вова on 07.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//
#import "DelegateNetwork.h"
#import "ParcingRequest.h"
#import "CollectionViewController.h"
#import "FilterViewController.h"
#import "FullScreenImage.h"
#import "ImageCollectionViewCell.h"

@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, NetworkServiceOutputProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) ParcingRequest *parcingRequest;
@property (strong, nonatomic) NSMutableArray *photoDataArray;
@property (strong, nonatomic) UIImageView *enlargePhoto;
@property (assign, nonatomic) NSUInteger numberOfPage;
@property (assign, nonatomic) NSUInteger totalPagesAmount;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIImage *enlargeImage;

@end

@implementation CollectionViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.photoDataArray = [NSMutableArray new];
    self.parcingRequest = [ParcingRequest new];
    self.parcingRequest.output = self;
    self.numberOfPage = 1;
    [self makeUI];
}

#pragma mark - Make UI

-(void)makeUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"Flickr";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Поиск" style:UIBarButtonItemStyleDone target:self action:@selector(searchButtonWasPressed)];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setMinimumInteritemSpacing:2];
    [layout setMinimumLineSpacing:2];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2 - 2, collectionView.frame.size.width/2 - 2);
}

#pragma mark - Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.enlargeImage = [UIImage imageWithData:self.photoDataArray[indexPath.row]];
    FullScreenImage *image = [[FullScreenImage alloc] initWithImage:self.enlargeImage andFlag:YES];
    [self.navigationController pushViewController:image animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.photoDataArray.count - 1) // Реализуем пагинацию
    {
        if (self.numberOfPage != self.totalPagesAmount) //Проверяем не дошли ли до последней страницы
        {
            self.numberOfPage++;
        }
        [self.parcingRequest findFlickrPhotoWithSearchString: self.textField.text currentPage: self.numberOfPage];
    }
}

#pragma mark - Collection View Data Source

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageWithData:self.photoDataArray[indexPath.row]];
    cell.imageView.layer.cornerRadius = 10.0;
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoDataArray.count;
}

#pragma mark - Network Delegate Response

- (void)loadingIsDoneWithDataRecieved:(NSMutableArray *)dataRecieved totalPagesAmount:(NSUInteger)totalPagesAmount
{
    self.totalPagesAmount = totalPagesAmount;
    [self.photoDataArray addObjectsFromArray: dataRecieved];
    [self.collectionView reloadData];
}

#pragma mark - Search Button Was Pressed

-(void)searchButtonWasPressed
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Поиск по Flickr"
                                                                             message:@"Введите тэг"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.placeholder = @"например: Nature";
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    
    UIAlertAction* search = [UIAlertAction actionWithTitle:@"Поиск" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        self.textField = alertController.textFields.firstObject;
        
        if (self.textField.text.length > 0)
        {
            [self.view endEditing:YES];
            [self.photoDataArray removeAllObjects];
            [self.collectionView reloadData];
            self.numberOfPage = 1;
            [self.parcingRequest findFlickrPhotoWithSearchString: self.textField.text currentPage: self.numberOfPage];
        }
    }];
    
    [alertController addAction:search];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action){
        [self.view endEditing:YES];
    }];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
