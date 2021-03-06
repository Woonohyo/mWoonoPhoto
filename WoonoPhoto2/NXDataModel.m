//
//  NXDataModel.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 4..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXDataModel.h"
#import <ImageIO/CGImageSource.h>
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
        _loginData = [[NSMutableDictionary alloc] initWithCapacity:2];
        _existData = [[NSMutableDictionary alloc] initWithCapacity:2];
        _responseData = [[NSMutableData alloc] initWithCapacity:10];
        NSString *aURLString = @"http://localhost:8080/post/list.json";
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
    _itemDictionary = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
    [_tableController.tableView reloadData];
    NSLog(@"result json = %@", _itemDictionary);
}

- (NSString*)description {
    //return _loginData.description;
    return _itemDictionary.description;
}

-(void)saveId:(NSString*)userId withPassword:(NSString*)password {
    [ _loginData setObject: userId forKey: kID_KEY ];
    [ _loginData setObject: password forKey: kPASSWORD_KEY ];
}

-(NSDictionary*)objectAtIndex:(NSUInteger)index {
    return _itemDictionary[@"posts"][index];
}

-(NSInteger)getListSize {
    NSArray* arr = [_itemDictionary objectForKey:@"posts"];
    NSLog(@"Posts count: %d", arr.count);
    return arr.count;
}


// 서버와 연동을 통해서 로그인 여부를 확인하는 메소드
- (BOOL)loginCheckViaNetwork:(NSString *)password userId:(NSString *)userId {
    //NSString * aURLString = @"http://1.234.2.8/login.php";
    NSString * aURLString = @"http://localhost:8080/logincheck.json";
    //NSString * aFormData = [NSString stringWithFormat:@"id=%@&passwd=%@", userId, password];
    NSString * aFormData = [NSString stringWithFormat:@"username=%@&password=%@", userId, password];
    
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
/*

-(void)sendPost:(UIImage *)image Title:(NSString *)title withContents:(NSString *)contents {
    NSLog(@"%@, %@, %@", image, title, contents);
    
    NSDateFormatter * time = [[NSDateFormatter alloc]init];
    [time setDateFormat:@"yyMMddHHmmss"];
    NSString * curDateTime = [time stringFromDate:[NSDate date]];
    NSLog(@"Current Time: %@", curDateTime);
    NSString * fileName = curDateTime;
    
    NSString * stringUrl = @"http://localhost:8080/new.json";
    NSURL * submitUrl = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest * submitRequest = [NSMutableURLRequest requestWithURL:submitUrl];
    [submitRequest setHTTPMethod:@"POST"]; // default는 GET
    
    NSString * splitter = @"----------SECTION END-----------";
    NSString * contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", splitter];
    [submitRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData * postBody = [NSMutableData data];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", splitter] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", title] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", splitter] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"contents\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", contents] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    if(imgData){
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", splitter] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"%@.jpg\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:imgData];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", splitter] dataUsingEncoding:NSUTF8StringEncoding]];
    [submitRequest setHTTPBody:postBody];
        
    NSHTTPURLResponse *submitResponse;
    NSError *submitError;
    NSData *submitResult = [NSURLConnection sendSynchronousRequest:submitRequest returningResponse:&submitResponse error:&submitError];
//    NSLog(@"%@", postBody);
    NSLog(@"submit response = %d", submitResponse.statusCode);
    NSLog(@"submit response = %@", submitResponse.URL);

}
*/



-(void)sendNewPost:(UIImage *)image Title:(NSString *)title withContents:(NSString *)contents {
    NSDateFormatter *time = [[NSDateFormatter alloc]init];
    [time setDateFormat:@"yyMMddHHmmss"];
    NSString *curDatetime = [time stringFromDate:[NSDate date]];
    NSString* imgName = curDatetime;
    NSLog(@"현재시간은!!!%@ 파일이름은 %@", curDatetime, imgName);
    
    NSString *submitURLString = @"http://localhost:8080/new.json";
    NSURL *submitURL = [NSURL URLWithString:submitURLString];
    NSMutableURLRequest *submitRequest = [NSMutableURLRequest requestWithURL:submitURL];
    [submitRequest setHTTPMethod:@"POST"]; // default는 GET
    
    NSString *stringBoundary = @"------dnsjgysmssjanrnlduqek------";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [submitRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", title] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"contents\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", contents] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    if(imgData){
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photoFile\"; filename=\"%@.jpg\"\r\n", imgName] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:imgData];
        [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [submitRequest setHTTPBody:postBody];
    
    NSHTTPURLResponse *submitResponse;
    NSError *submitError;
    NSData *submitResult = [NSURLConnection sendSynchronousRequest:submitRequest returningResponse:&submitResponse error:&submitError];
    NSLog(@"submit response = %d", submitResponse.statusCode); //통신 성공여부

}


@end
