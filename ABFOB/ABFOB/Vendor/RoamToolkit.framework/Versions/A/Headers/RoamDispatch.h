//
//  RoamDispatch.h
//
//  Copyright © Roam Creative. All rights reserved.
//

void run_main(dispatch_block_t block);

void run_background(dispatch_block_t block);

void run_delayed(float delay, dispatch_block_t block);
