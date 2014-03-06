//
//  STKPhotosDataSource.h
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kPhotoCellID = @"photoCell";

@interface STKPhotosDataSource : NSObject

@property (strong, nonatomic) NSArray *photos;

- (instancetype)initWithPhotos:(NSArray *)photos;

@end
