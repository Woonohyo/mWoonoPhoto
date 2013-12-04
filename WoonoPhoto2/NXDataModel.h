//
//  NXDataModel.h
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 4..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXDataModel : NSObject

-(void)saveId:(NSString*)userId withPassword:(NSString*)password;
-(BOOL)authenticateId:(NSString*)userId withPassword:(NSString*)password;
-(NSDictionary*)objectAtIndex:(NSUInteger)index;

@end
