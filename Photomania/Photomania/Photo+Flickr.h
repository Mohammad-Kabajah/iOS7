//
//  Photo+Flickr.h
//  Photomania
//
//  Created by Mohammad Kabajah on 8/24/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+(Photo *) photoWithFlickrInfo:(NSDictionary *)photoDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context;

+(void) loadPhotosFromFlickrArray:(NSArray *)photos  // of Flickr Dictionary
        intoManagedObjectContext:(NSManagedObjectContext *)context;

@end
