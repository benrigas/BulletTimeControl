//
//  MulticastSender.m
//  BulletTimeControl
//
//  Created by Ben Rigas on 11/6/18.
//  Copyright © 2018 Rigas. All rights reserved.
//

#import "MulticastSender.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

@implementation MulticastSender

+ (void)sendBroadcast {
    unsigned int        wifiInterface;
    int                fd;
    BOOL                success;
    struct sockaddr_in  destAddr;
    NSData *            payloadData;
    ssize_t            bytesSent;
    
    wifiInterface = if_nametoindex("en0");
    assert(wifiInterface != 0);
    
    fd = socket(AF_INET, SOCK_DGRAM, 0);
    assert(fd >= 0);
    
    static const int kOne = 1;
    success = setsockopt(fd, SOL_SOCKET, SO_BROADCAST, &kOne, sizeof(kOne)) == 0;
    assert(success);
    
    success = setsockopt(fd, IPPROTO_IP, IP_BOUND_IF, &wifiInterface, sizeof(wifiInterface)) == 0;
    assert(success);
    
    memset(&destAddr, 0, sizeof(destAddr));
    destAddr.sin_family = AF_INET;
    destAddr.sin_len = sizeof(destAddr);
    destAddr.sin_addr.s_addr = INADDR_BROADCAST;
    destAddr.sin_port = htons(12345);
    
    payloadData = [[NSString stringWithFormat:@"%@\r\n", [NSDate date]] dataUsingEncoding:NSUTF8StringEncoding];
    
    bytesSent = sendto(fd, payloadData.bytes, payloadData.length, 0, (const struct sockaddr *) &destAddr, sizeof(destAddr));
    if (bytesSent >= 0) {
        NSLog(@"success");
    } else {
        NSLog(@"error %d", errno);
    }
    
    success = close(fd) == 0;
    assert(success);
}

@end
