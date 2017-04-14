//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Mohammad Kabajah on 8/21/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
@implementation ImageViewController

-(void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    _scrollView.maximumZoomScale = 5.0;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.imageView;
}

-(void)setImageURL:(NSURL *)imageURL{
    _imageURL = imageURL;
    //this line of code worj in the main queue (main thread)
//    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    
    [self startDownloadingImage];
}

-(void)startDownloadingImage{
    self.image = nil;
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        
        //working in the background even if the app is closed
        //need multi tasking to do it
        //backgroundSessionConfigurationWithIdentifier:<#(NSString *)#>
        
        //doanloading multiple files or keep the session active to do multiple things
        //defaultSessionConfiguration
        
        //if you wanna download sth and you are gonna be done
        //ephemeralSessionConfiguration

        //for ephemeralSessionConfiguration we use the session without the delegate
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        //for thebackgroundSessionConfigurationWithIdentifier we use the session with delegate
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"foo"];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:<#(id<NSURLSessionDelegate>)#> delegateQueue:<#(NSOperationQueue *)#>:configuration];
        
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.imageURL]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                                    //the following 2 lines are the same
                                                                    //doing the same job
                                                                    dispatch_async(dispatch_get_main_queue(), ^{self.image = image;});
//                                                                    [self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                                                                    
                                                                }
                                                            }
                                                        }];
        [task resume];
        
    };
    
}

-(UIImageView *)imageView{
    if (!_imageView){
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}


//@synthesize image is not needed here because we are not using the instence variable _image here
//@synthesize create the instance variable _image

-(UIImage *)image{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image{
    self.imageView.image= image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollView addSubview:self.imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
