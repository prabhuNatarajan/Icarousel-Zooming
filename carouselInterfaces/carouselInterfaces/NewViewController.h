//
//  NewViewController.h
//  carouselInterfaces
//
//  Created by Apple on 31/12/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController

@property (strong, nonatomic) NSString *selectedImageName;
@property (strong, nonatomic) UIImageView *selectedImage;
- (IBAction)back:(id)sender;

@end
