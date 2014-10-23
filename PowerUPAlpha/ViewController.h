//
//  ViewController.h
//  PowerUPAlpha
//
//  Created by Cyrus Huang on 10/22/14.
//  Copyright (c) 2014 CS121F14S4_Team8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet
    UISegmentedControl* segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton* about;
@property (weak, nonatomic) IBOutlet UIButton* level;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

@end

