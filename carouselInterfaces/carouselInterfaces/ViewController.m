//
//  ViewController.m
//  carouselInterfaces
//
//  Created by Apple on 31/12/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *photoArray;
@property (strong, nonatomic) UIView *views;
@property (nonatomic) BOOL expanded;
@property (strong, nonatomic) UIImageView *zoomImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //configure carousel

    self.customCarouselView.type = iCarouselTypeCoverFlow2;
    self.customCarouselView.decelerationRate = 0.0f;
    self.customCarouselView.stopAtItemBoundary = YES;
    self.customCarouselView.scrollToItemBoundary = YES;
    self.customCarouselView.scrollSpeed = 0.2f;
    self.zoomImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 130, 200, 200)];
    [self.view addSubview:self.zoomImage];
    self.zoomImage.hidden = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark iCarousel methods
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
     self.photoArray = [[NSArray alloc]initWithObjects:@"200.jpg",@"201.jpg",@"202.jpg",@"203.jpg",@"204.jpg",@"205.jpg",@"206.jpg",@"207.jpg",@"208.jpg",@"209.jpg",@"210.jpg", nil];
    NSLog(@"returns %lu", (unsigned long) self.photoArray.count);
    return [self.photoArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    if (_views == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.layer.cornerRadius = 0.0;
        view.layer.masksToBounds = YES;
        view.layer.doubleSided = YES;
        //view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
        
    }
    else
    {
        //get a reference to the label in the recycled view
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [_items[index] stringValue];
    
    //Shows the id name
    //label.text = [self.idList [index] description];
    
    //For showing images
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        dispatch_async(dispatch_get_main_queue(), ^{
            ((UIImageView *)view).image = [UIImage imageNamed:[self.photoArray objectAtIndex:index]];
            self.zoomImage.image = [UIImage imageNamed:[self.photoArray objectAtIndex:index]];
        });
    });
    
    return view;
}

- (void)alterButton
{
    self.zoomImage.hidden = NO;
    self.customCarouselView.scrollEnabled = NO;
    [UIView transitionWithView:self.view duration:2.0 options:UIViewAnimationOptionTransitionNone animations:^{
        [self.zoomImage setFrame:CGRectMake(10, 84, 300, 320)];

    }completion:nil];
    self.expanded = YES;
}

- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index
{
    return YES;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    //Zooming the Image
    self.zoomImage.image = [UIImage imageNamed:[self.photoArray objectAtIndex:index]];
    
    
    [self alterButton];
    
    NSTimeInterval delayInSeconds = 3.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
     
        NSString *storyBoardName = @"Main";
        NSString *viewControllerId = @"NewViewController";
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
        NewViewController *ViewController = (NewViewController *) [storyBoard instantiateViewControllerWithIdentifier:viewControllerId];
        ViewController.selectedImageName = [self.photoArray objectAtIndex:index];
        [self presentViewController:ViewController animated:NO completion:nil];
        
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.customCarouselView.scrollEnabled = YES;
    self.zoomImage.hidden = YES;
    [self.zoomImage setFrame:CGRectMake(60, 130, 200, 200)];
}

@end
