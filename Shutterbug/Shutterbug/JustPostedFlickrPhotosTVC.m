//
//  JustPostedFlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Mohammad Kabajah on 8/22/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "JustPostedFlickrPhotosTVC.h"
#import "FlickrFetcher.h"
@interface JustPostedFlickrPhotosTVC ()

@end

@implementation JustPostedFlickrPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchPhotos];
}

-(IBAction)fetchPhotos{
    [self.refreshControl beginRefreshing];
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
//    NSError *error=nil;
    /*
#warning Block Main Thread
    NSDictionary *propertiyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                         options:0
//                                                                           error:&error];
                                                                           error:NULL];
    NSLog(@"Flicker results = %@",propertiyListResults);
    NSArray *photos  = [propertiyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
    self.photos =photos;
     */
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSDictionary *propertiyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                             options:0
                                              //                                                                           error:&error];
                                                                               error:NULL];
        NSLog(@"Flicker results = %@",propertiyListResults);
        NSArray *photos  = [propertiyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.photos =photos;
            
        });
        
    });

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
