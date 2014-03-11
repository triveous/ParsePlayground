//
//  STKAllPhotosViewController.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKAllPhotosViewController.h"
#import "STKPhotosDataSource.h"
#import "STKApiConstants.h"

@interface STKAllPhotosViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet STKPhotosDataSource *dataSource;

@end

@implementation STKAllPhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"STKPhotoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kPhotoCellID];
    
    [PFAnalytics trackEvent:@"AllPhotosViewed" dimensions:@{@"User" : [PFUser currentUser].username}];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadPhotos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dataSource.photos = objects;
        
        [self.collectionView reloadData];
    }];
}

@end
