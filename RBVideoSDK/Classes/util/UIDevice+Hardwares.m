//
//  UIDevice+Hardware.m
//  TestTable
//
//  Created by Inder Kumar Rathore on 19/01/13.
//  Copyright (c) 2013 Rathore. All rights reserved.
//

#import "UIDevice+Hardwares.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

@implementation UIDevice (Hardwares)
- (NSString*)hardwareString {
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = malloc(size);

    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}
- (NSString*)hardwareDescription {
    NSString *hardware = [self hardwareString];
    NSDictionary *deviceList = [self getDeviceList];
    NSString *hardwareDescription = [[deviceList objectForKey:hardware] objectForKey:@"name"];
    if (hardwareDescription) {
        return hardwareDescription;
    }
    else {
        //log message that your device is not present in the list
        [self logMessage:hardware];
        
        return nil;
    }
}
- (NSDictionary *)getDeviceList {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DeviceList" ofType:@"plist"];
    NSDictionary *deviceList = [NSDictionary dictionaryWithContentsOfFile:path];
    NSAssert(deviceList != nil, @"DevicePlist not found in the bundle.");
    return deviceList;
}

- (Hardware)hardware {
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:iPhone1_1])    return IPHONE_2G;
    if ([hardware isEqualToString:iPhone1_2])    return IPHONE_3G;
    if ([hardware isEqualToString:iPhone2_1])    return IPHONE_3GS;
    
    if ([hardware isEqualToString:iPhone3_1])    return IPHONE_4;
    if ([hardware isEqualToString:iPhone3_2])    return IPHONE_4;
    if ([hardware isEqualToString:iPhone3_3])    return IPHONE_4_CDMA;
    if ([hardware isEqualToString:iPhone4_1])    return IPHONE_4S;
    
    if ([hardware isEqualToString:iPhone5_1])    return IPHONE_5;
    if ([hardware isEqualToString:iPhone5_2])    return IPHONE_5_CDMA_GSM;
    if ([hardware isEqualToString:iPhone5_3])    return IPHONE_5C;
    if ([hardware isEqualToString:iPhone5_4])    return IPHONE_5C_CDMA_GSM;
    if ([hardware isEqualToString:iPhone6_1])    return IPHONE_5S;
    if ([hardware isEqualToString:iPhone6_2])    return IPHONE_5S_CDMA_GSM;
    
    if ([hardware isEqualToString:iPhone7_1])    return IPHONE_6_PLUS;
    if ([hardware isEqualToString:iPhone7_2])    return IPHONE_6;
    if ([hardware isEqualToString:iPhone8_1])    return IPHONE_6S;
    if ([hardware isEqualToString:iPhone8_2])    return IPHONE_6S_PLUS;
    if ([hardware isEqualToString:iPhone8_4])    return IPHONE_SE;
    
    if ([hardware isEqualToString:iPod1_1])      return IPOD_TOUCH_1G;
    if ([hardware isEqualToString:iPod2_1])      return IPOD_TOUCH_2G;
    if ([hardware isEqualToString:iPod3_1])      return IPOD_TOUCH_3G;
    if ([hardware isEqualToString:iPod4_1])      return IPOD_TOUCH_4G;
    if ([hardware isEqualToString:iPod5_1])      return IPOD_TOUCH_5G;
    if ([hardware isEqualToString:iPod7_1])      return IPOD_TOUCH_6G;
    
    if ([hardware isEqualToString:iPad1_1])      return IPAD;
    if ([hardware isEqualToString:iPad1_2])      return IPAD_3G;
    if ([hardware isEqualToString:iPad2_1])      return IPAD_2_WIFI;
    if ([hardware isEqualToString:iPad2_2])      return IPAD_2;
    if ([hardware isEqualToString:iPad2_3])      return IPAD_2_CDMA;
    if ([hardware isEqualToString:iPad2_4])      return IPAD_2;
    if ([hardware isEqualToString:iPad2_5])      return IPAD_MINI_WIFI;
    if ([hardware isEqualToString:iPad2_6])      return IPAD_MINI;
    if ([hardware isEqualToString:iPad2_7])      return IPAD_MINI_WIFI_CDMA;
    if ([hardware isEqualToString:iPad3_1])      return IPAD_3_WIFI;
    if ([hardware isEqualToString:iPad3_2])      return IPAD_3_WIFI_CDMA;
    if ([hardware isEqualToString:iPad3_3])      return IPAD_3;
    if ([hardware isEqualToString:iPad3_4])      return IPAD_4_WIFI;
    if ([hardware isEqualToString:iPad3_5])      return IPAD_4;
    if ([hardware isEqualToString:iPad3_6])      return IPAD_4_GSM_CDMA;
    if ([hardware isEqualToString:iPad4_1])      return IPAD_AIR_WIFI;
    if ([hardware isEqualToString:iPad4_2])      return IPAD_AIR_WIFI_GSM;
    if ([hardware isEqualToString:iPad4_3])      return IPAD_AIR_WIFI_CDMA;
    if ([hardware isEqualToString:iPad4_4])      return IPAD_MINI_RETINA_WIFI;
    if ([hardware isEqualToString:iPad4_5])      return IPAD_MINI_RETINA_WIFI_CDMA;
    if ([hardware isEqualToString:iPad4_6])      return IPAD_MINI_RETINA_WIFI_CELLULAR_CN;
    if ([hardware isEqualToString:iPad4_7])      return IPAD_MINI_3_WIFI;
    if ([hardware isEqualToString:iPad4_8])      return IPAD_MINI_3_WIFI_CELLULAR;
    if ([hardware isEqualToString:iPad4_9])      return IPAD_MINI_3_WIFI_CELLULAR_CN;
    if ([hardware isEqualToString:iPad5_1])      return IPAD_MINI_4_WIFI;
    if ([hardware isEqualToString:iPad5_2])      return IPAD_MINI_4_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:iPad5_3])      return IPAD_AIR_2_WIFI;
    if ([hardware isEqualToString:iPad5_4])      return IPAD_AIR_2_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:iPad6_3])      return IPAD_PRO_97_WIFI;
    if ([hardware isEqualToString:iPad6_4])      return IPAD_PRO_97_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:iPad6_7])      return IPAD_PRO_WIFI;
    if ([hardware isEqualToString:iPad6_8])      return IPAD_PRO_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:i386_Sim])         return SIMULATOR;
    if ([hardware isEqualToString:x86_64_Sim])       return SIMULATOR;
    return NOT_AVAILABLE;
}





- (float)hardwareNumber {
    NSString *hardware = [self hardwareString];
    NSDictionary *deviceList = [self getDeviceList];
    float version = [[[deviceList objectForKey:hardware] objectForKey:@"version"] floatValue];
    if (version != 0.0f) {
        return version;
    }
    else {
        //log message that your device is not present in the list
        [self logMessage:hardware];
        
        return 200.0f; //device might be new one of missing one so returning 200.0f
    }
}


- (CGSize)backCameraStillImageResolutionInPixels
{
    switch ([self hardware]) {
        case IPHONE_2G:
        case IPHONE_3G:
            return CGSizeMake(1600, 1200);
            break;
        case IPHONE_3GS:
            return CGSizeMake(2048, 1536);
            break;
        case IPHONE_4:
        case IPHONE_4_CDMA:
        case IPAD_3_WIFI:
        case IPAD_3_WIFI_CDMA:
        case IPAD_3:
        case IPAD_4_WIFI:
        case IPAD_4:
        case IPAD_4_GSM_CDMA:
            return CGSizeMake(2592, 1936);
            break;
        case IPHONE_4S:
        case IPHONE_5:
        case IPHONE_5_CDMA_GSM:
        case IPHONE_5C:
        case IPHONE_5C_CDMA_GSM:
            return CGSizeMake(3264, 2448);
            break;
            
        case IPOD_TOUCH_4G:
            return CGSizeMake(960, 720);
            break;
        case IPOD_TOUCH_5G:
            return CGSizeMake(2440, 1605);
            break;
            
        case IPAD_2_WIFI:
        case IPAD_2:
        case IPAD_2_CDMA:
            return CGSizeMake(872, 720);
            break;
            
        case IPAD_MINI_WIFI:
        case IPAD_MINI:
        case IPAD_MINI_WIFI_CDMA:
            return CGSizeMake(1820, 1304);
            break;
        default:
            NSLog(@"We have no resolution for your device's camera listed in this category. Please, make photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository on GitHub.com in format Device = Hpx x Wpx.");
            NSLog(@"Your device is: %@", [self hardwareDescription]);
            break;
    }
    return CGSizeZero;
}

- (BOOL)isIphoneWith4inchDisplay
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        double height = [[UIScreen mainScreen] bounds].size.height;
        if (fabs(height-568.0f) < DBL_EPSILON) {
            return YES;
        }
    }
    return NO;
}

//是否是大于 iPhone4的机型
- (BOOL)isMoreThanIphone4{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        double height = [[UIScreen mainScreen] bounds].size.height;
        if (fabs(height - 480.0f)>0) {
            return YES;
        }
    }
    return NO;
}


+ (NSString *)macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - sysctl utils

+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)cpuFrequency {
    return [self getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)busFrequency {
    return [self getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
    return [self getSysInfo:HW_NCPU];
}


+ (NSUInteger)totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information

+ (long long)freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}


+ (BOOL)isIOS7{
    //check systemVerson of device
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 7.0f&&sysVersion <=8.0) {
        return YES;
    }
    return NO;
}
+ (BOOL)isIOS8{
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 8.0) {
        return YES;
    }
    return NO;
}
- (void)logMessage:(NSString *)hardware {
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/InderKumarRathore/DeviceUtil and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
}
@end
