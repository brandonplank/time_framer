//
//  time_framer.h
//  time_frame
//
//  Created by Brandon Plank on 7/17/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

#ifndef time_framer_h
#define time_framer_h

extern uint64_t selfproc_cached;
extern mach_port_t tfp0;
extern uint64_t kernel_slide;
extern uint64_t kernel_base;
extern uint64_t task_self_cache;

int run_time_waste(void);

uint64_t getselfproc(void);

#endif /* time_framer_h */
