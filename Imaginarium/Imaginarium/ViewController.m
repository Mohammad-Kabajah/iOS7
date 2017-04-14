//
//  ViewController.m
//  Imaginarium
//
//  Created by Mohammad Kabajah on 8/21/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *) segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://adrianlatorre.com/projects/inexus/images.apple.com/v/iphone-5s/gallery/a/images/%@.jpg",segue.identifier]];
        ivc.title = segue.identifier;
        
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
