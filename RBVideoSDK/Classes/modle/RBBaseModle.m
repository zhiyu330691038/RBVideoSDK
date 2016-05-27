//
//  RBBaseModle.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBBaseModle.h"
#import <objc/message.h>
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


@implementation RBBaseModle

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self parseData:dict];
    }
    
    return self;

}

- (void)parseData:(NSDictionary *)dict{
    if([dict count] == 0)
        return;

    NSMutableArray * prolist = nil;
    [RBBaseModle getAllPropertyList:&prolist Class:[self class]];
    
    for(NSString * propertyName in prolist){
        NSString * pro = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] uppercaseString]];
  
        
        NSString *destMethodName = [NSString stringWithFormat:@"set%@:",pro]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
        SEL destMethodSelector = NSSelectorFromString(destMethodName);
        NSString * newpro = propertyName;
        if([propertyName isEqualToString:@"cid"]){
            newpro = @"id";
        }
        NSObject * value = [dict objectForKey:newpro];
        
       
        
        if ([self respondsToSelector:destMethodSelector] && value) {
            [self performSelector:destMethodSelector withObject:value];
        }
    }
    
}


+ (void)getAllPropertyList:(NSMutableArray **) protocollist Class:(Class)classtype{
    
    if(*protocollist == nil || ![*protocollist isKindOfClass:[NSMutableArray class]]){
        *protocollist = [NSMutableArray new];
    }
    u_int count;
    objc_property_t * properties = class_copyPropertyList(classtype, &count);
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        NSString * property = [NSString stringWithUTF8String:propertyName];
        if([property isEqualToString:@"dealDelegate"])
            continue;
        [*protocollist addObject:property];
    }
    free(properties);
    Class suClass = [classtype superclass];
    if(![[[NSObject class] description] isEqualToString:[suClass description]]){
        [RBBaseModle getAllPropertyList:protocollist Class:suClass];
        return;
    }
}


- (NSDictionary *)toDict{
    NSMutableDictionary * resultdict = [NSMutableDictionary dictionary] ;

    NSMutableArray * prolist = nil;
    [RBBaseModle getAllPropertyList:&prolist Class:[self class]];
    
    for(NSString * propertyName in prolist){
    
        SEL seleter = NSSelectorFromString(propertyName);
        id value = [self performSelector:seleter];
        if(value != nil){
        
            id resultValue = nil;
            
            if([value isKindOfClass:[NSArray class]]){
                NSMutableArray * array = [NSMutableArray new];
                for(RBBaseModle * modle in value){
                    if([modle isKindOfClass:[RBBaseModle class]]){
                        [array addObject:[modle toDict]];
                    }else{
                        [array addObject:modle];
                    }
                }
                resultValue = [array copy];
            }else if([value isKindOfClass:[RBBaseModle class]]){
                resultValue = [value toDict];
            }else{
                resultValue = value;
            }
            [resultdict setObject:resultValue forKey:propertyName];
        
        }
    }
    return resultdict;
}
- (NSString *)toJSON{
    
    NSDictionary * dict = [self toDict];
    
    if([NSJSONSerialization isValidJSONObject:dict]){
        NSData  * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return @"";
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"Modle Class (%@)\n%@",[self class],[[[[self toJSON] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"	" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
}
@end
