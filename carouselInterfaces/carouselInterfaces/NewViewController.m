//
//  NewViewController.m
//  carouselInterfaces
//
//  Created by Apple on 31/12/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

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
	// Do any additional setup after loading the view.
    self.selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 84, 300, 320)];
    self.selectedImage.image = [UIImage imageNamed:self.selectedImageName];
    [self.view addSubview:self.selectedImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [UIView transitionWithView:self.view duration:2.0 options:UIViewAnimationOptionTransitionNone animations:^{
        [self.selectedImage setFrame:CGRectMake(60, 130, 200, 200)];
        
    }completion:nil];
    NSTimeInterval delayInSeconds = 02.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self dismissViewControllerAnimated:NO completion:nil];
    });
}

@end
