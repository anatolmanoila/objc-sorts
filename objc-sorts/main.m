//
//  main.m
//  objc-sorts
//
//  Created by Jesse Squires on 6/6/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "merge_sort.h"
#import "quick_sort.h"
#import "selection_sort.h"
#import "bubble_sort.h"

#define MAX_COUNT 10000

NSMutableArray* randomNumbersArray()
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for(NSUInteger i = 0; i < MAX_COUNT; i++) {
        int num = arc4random() % INT16_MAX;
        BOOL sign = ((arc4random() % 2) + 1) % 2 == 0;
        num *= (sign ? -1 : 1);
        [list addObject:[NSNumber numberWithInteger:num]];
    }
    
    return list;
}

BOOL verfiySorted(NSMutableArray *arr)
{
    NSLog(@"Verifying sorted list...");
    for(NSUInteger i = 0; i < arr.count-1; i++) {
        NSInteger a = [[arr objectAtIndex:i] integerValue];
        NSInteger b = [[arr objectAtIndex:i+1] integerValue];
        if(a > b) {
            NSLog(@"List is NOT sorted!");
            return NO;
        }
    }
    NSLog(@"List is sorted!");
    return YES;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"Generating random list of %d numbers...", MAX_COUNT);
        NSMutableArray *unsorted = randomNumbersArray();
        verfiySorted(unsorted);
        
        NSDate *start = nil;
        NSTimeInterval end = 0;
        NSMutableArray *copy = nil;
        
        NSLog(@"\n\nRunning quick sort...");
        copy = [unsorted mutableCopy];
        start = [NSDate date];
        quick_sort(copy, 0, copy.count - 1);
        end = [start timeIntervalSinceNow] * -1;
        verfiySorted(copy);
        NSLog(@"Quick sort DONE: %lf", end);
        
        
        NSLog(@"\n\nRunning merge sort...");
        copy = [unsorted mutableCopy];
        start = [NSDate date];
        merge_sort(copy, 0, copy.count);
        end = [start timeIntervalSinceNow] * -1;
        verfiySorted(copy);
        NSLog(@"Merge sort DONE: %lf", end);
        
        
        NSLog(@"\n\nRunning selection sort...");
        copy = [unsorted mutableCopy];
        start = [NSDate date];
        selection_sort(copy);
        end = [start timeIntervalSinceNow] * -1;
        verfiySorted(copy);
        NSLog(@"Selection sort DONE: %lf", end);
        
        
        NSLog(@"\n\nRunning bubble sort...");
        copy = [unsorted mutableCopy];
        start = [NSDate date];
        bubble_sort(copy);
        end = [start timeIntervalSinceNow] * -1;
        verfiySorted(copy);
        NSLog(@"Bubble sort DONE: %lf", end);
    }
    return 0;
}
