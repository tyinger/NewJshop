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
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

@end
