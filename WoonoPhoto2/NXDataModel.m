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
    NSMutableData* _responseData;
}

- (id)init {
    self = [super init];
    if (self) {
        /*_itemArray = [@[
                        @{ @"title": @"첫번째", @"content": @"Suzi", @"image":@"suzi.jpg"},
                        @{ @"title": @"두번째", @"content": @"Usami", @"image":@"Usami.jpg"},
                        @{ @"title": @"세번째", @"content": @"Suzi", @"image":@"suzi.jpg"}
                        ] mutableCopy]; // mutableArray에는 mutableCopy를 넣어준다.
         */
        
        //_itemDictionary = @{@"name": @"Woonohyo", @"age": @16, @"male": @YES, @"array": _itemArray};
        // 이렇게 생성해도 좋다.
        // NSMutableArray * _newArray = [@[@"apple"] mutableCopy];
        // 하지만 생성자를 다 쓰는 방식이 일반적
        
        _loginData = [[NSMutableDictionary alloc] initWithCapacity:2];
        _existData = [[NSMutableDictionary alloc] initWithCapacity:2];
        _responseData = [[NSMutableData alloc] initWithCapacity:10];
        NSString *aURLString = @"http://1.234.2.8/board.php";
        NSURL *aURL = [NSURL URLWithString:aURLString];
        NSURLRequest *aRequest = [NSMutableURLRequest requestWithURL:aURL];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:aRequest delegate:self startImmediately:YES];
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _itemArray = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
    [_tableController.tableView reloadData];
    //NSLog(@"result json = %@", _itemArray);
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

-(NSInteger)getListSize {
    return [_itemArray count];
}


// 서버와 연동을 통해서 로그인 여부를 확인하는 메소드
- (BOOL)loginCheckViaNetwork:(NSString *)password userId:(NSString *)userId {
    NSString * aURLString = @"http://1.234.2.8/login.php";
    //NSString * aURLString = @"http://localhost:8080/logincheck";
    NSString * aFormData = [NSString stringWithFormat:@"id=%@&passwd=%@", userId, password];
    NSURL * aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest * aRequest = [NSMutableURLRequest requestWithURL:aURL];
    
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody: [aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse * aResponse;
    NSError * aError;
    NSData * aResultData = [NSURLConnection sendSynchronousRequest:aRequest returningResponse:&aResponse error:&aError];
    NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:aResultData options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"login response = %d", aResponse.statusCode);
    NSLog(@"login result = %@", dataDictionary);
    
    return ([[dataDictionary objectForKey:@"result"] isEqualToString:@"OK"]);
}

// 일단은 ID와 PASSWORD를 같게(ID==PASSWORD) 입력했을 때에만 Segue를 진행하게끔 구현했습니다.
// 추후 DB와 연동이 되면 이 곳만 수정하면 될 듯 합니다!
// 결국 구시대의 메소드로 전락.
-(BOOL)authenticateId:(NSString*)userId withPassword:(NSString*)password {
    if ([userId length] == 0 || [password length] == 0)
        return false;
    
    if ([userId isEqualToString:password])
        return true;
    else
        return false;
}

@end
