//
//  STKPhotosDataSource.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKPhotosDataSource.h"
#import "STKPhotoCell.h"
#import "STKApiConstants.h"

@interface STKPhotosDataSource ()

@end

@implementation STKPhotosDataSource

- (instancetype)initWithPhotos:(NSArray *)photos
{
    self = [super init];
    if (self) {
        self.photos = photos;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STKPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellID forIndexPath:indexPath];
    
    PFObject *photo = self.photos[indexPath.row];
    PFFile *imageFile = photo[kPhotoFile];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        cell.photo.image = image;
    }];
    
    return cell;
}

@end
