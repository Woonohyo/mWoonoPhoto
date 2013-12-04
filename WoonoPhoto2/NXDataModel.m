//
//  NXDataModel.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 4..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXDataModel.h"
#define kPASSWORD_KEY @"password"
#define kID_KEY @"userId"


@implementation NXDataModel
{
    NSMutableArray* _itemArray;
    NSDictionary* _itemDictionary;
    NSMutableDictionary* _loginData;
    NSMutableDictionary* _existData;
}

- (id)init {
    self = [super init];
    if (self) {
        _itemArray = [@[
                        @{ @"text": @"첫번째", @"image":@"1.png" },
                        @{ @"text": @"두번째", @"image":@"2.png" },
                        @{ @"text": @"세번째", @"image":@"3.png" }
                        ] mutableCopy]; // mutableArray에는 mutableCopy를 넣어준다.
        
        _itemDictionary = @{@"name": @"Woonohyo", @"age": @16, @"male": @YES, @"array": _itemArray};
        // 이렇게 생성해도 좋다.
        // NSMutableArray * _newArray = [@[@"apple"] mutableCopy];
        // 하지만 생성자를 다 쓰는 방식이 일반적
        
        _loginData = [[NSMutableDictionary alloc] initWithCapacity:2];
        _existData = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    
    return self;
}

- (NSString*)description {
    return _loginData.description;
    //return _itemArray.description;
}

-(void)saveId:(NSString*)userId withPassword:(NSString*)password {
    [ _loginData setObject: userId forKey: kID_KEY ];
    [ _loginData setObject: password forKey: kPASSWORD_KEY ];
}

-(NSDictionary*)objectAtIndex:(NSUInteger)index {
    return _itemArray[index];
}

// 일단은 ID와 PASSWORD를 같게(ID==PASSWORD) 입력했을 때에만 Segue를 진행하게끔 구현했습니다.
// 추후 DB와 연동이 되면 이 곳만 수정하면 될 듯 합니다!
-(BOOL)authenticateId:(NSString*)userId withPassword:(NSString*)password {
    if ([userId isEqualToString:password])
        return true;
    else
        return false;
}


@end
