//
//  ViewController.m
//  LinkTest
//
//  Created by Stanislav Volskyi on 8/16/17.
//  Copyright © 2017 Stanislav Volskyi. All rights reserved.
//

#import "ViewController.h"

static CGFloat const itemWidth = 50.0;
static CGFloat const cellsSpacing = 10.0;
static CGFloat const sectionInset = 10.0;

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidthConstraint;

@end

@implementation ViewController

#pragma mark - ViewLifeCycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self updateCollectionViewWidth];
}

#pragma mark - UI

- (void)updateCollectionViewWidth
{
  [self.collectionView reloadData];
  
  NSInteger itemsCount = self.segmentControl.selectedSegmentIndex + 1;
  itemsCount = MIN(4, itemsCount);
  CGFloat newWidth = itemWidth * itemsCount + cellsSpacing * itemsCount + sectionInset;
  [UIView animateWithDuration:0.3 animations:^{
    self.collectionViewWidthConstraint.constant = newWidth;
    [self.view layoutIfNeeded];
  }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.segmentControl.selectedSegmentIndex + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
  return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"selected item at index %zd", indexPath.row);
}

#pragma mark - Actions

- (IBAction)numberOfItemsChanged:(UISegmentedControl *)sender
{
  [self updateCollectionViewWidth];
}

@end
