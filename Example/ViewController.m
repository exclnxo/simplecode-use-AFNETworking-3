//
//  ViewController.m
//  Example
//
//  Created by 徐常璿 on 2016/6/8.
//  Copyright © 2016年 Eric Hsu. All rights reserved.
//
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "MyManager.h"
@interface ViewController (){
   
    NSString *jsonusername;
    NSString *jsonpassword;
    NSString *response;
    MyManager * sharedManager;
}
@property (strong, nonatomic) IBOutlet UITextField *userIDTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (BOOL)validateAccount:(NSString *)account{
//    NSString *regex = @"[A-Z0-9a-z]{1,18}";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [predicate evaluateWithObject:account];
//}
//
//- (BOOL)validatePassword:(NSString *)password{
//    NSString *regex = @"[A-Z0-9a-z]{6,18}";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [predicate evaluateWithObject:password];
//}
- (IBAction)signUpBtn:(id)sender {
    
    NSString * username =_userIDTF.text;
    
    NSString * password =_passwordTF.text;
    
    
    NSString * post = @"http://localhost/Telephone/api.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:username,@"id",  password,@"pw",  nil];
    NSURLSessionDataTask *task=[manager POST:post parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * loginmessage =[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        MyManager * sharedManager =[MyManager sharedManager];
        sharedManager.member = @[loginmessage];
    
        NSLog(@"login:%@",sharedManager.member[0]);
        
        
        if ( [sharedManager.member[0] isEqualToString:@"success!!"]) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"登入訊息"
                                                                           message:@"登入成功！！"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"登入訊息"
                                                                           message:@"登入失敗！！"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
    [task resume];
    
//   
//
//     MyManager * sharedManager =[MyManager sharedManager];
//    
//    for (int i=0; i<sharedManager.member.count; i++) {
//        if ([username isEqualToString: sharedManager.member[i][@"username"]]==true) {
//            NSLog(@"比對成功");
//            NSLog(@"%@",sharedManager.member[i][@"username"]);
//             a= a+1;
//            break;
//            
//        }
//
//    }
    
    
}
- (IBAction)signin:(id)sender {
    NSString * username =_userIDTF.text;
   
    NSString * password =_passwordTF.text;
    
   
//    NSURL *url =[NSURL URLWithString:@"http://localhost/api.php"];
    NSString * post = @"http://localhost/Telephone/register_finish.php";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //產生控制request的物件
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:username,@"id",  password,@"pw",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    NSURLSessionDataTask *task =[manager POST:post parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *response = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"submit:%@",response);
//         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:nil error:nil ];
//        NSLog(@"json:%@",json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error%@",error);
    }];
    [task resume];
}

@end
