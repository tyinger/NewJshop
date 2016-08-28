//
//  NSString+File.m
//  MaiQuan
//
//  Created by 王圆的Mac on 14-1-23.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//

#import "NSString+File.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (File)

//文字拼接方法
- (NSString *)filenameAppend:(NSString *)append
{
   //1获取有拓展名的文件名
    NSString *filename = [self stringByDeletingPathExtension];
    
    //2拼接append
    filename = [filename stringByAppendingString:append];
    
    //3得到拓展名
    NSString *pathExtension = [self pathExtension];
    
    //拼接上拓展名
    return [filename stringByAppendingPathExtension:pathExtension];
   

}

+ (int)lengthToHanZi:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

-(id)JSONValue;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return result;
}

+ (NSString *)changemd:(NSString *)str{
    
    const char* original_str = [str UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, strlen(original_str), digist);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02X", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString];
}

@end
