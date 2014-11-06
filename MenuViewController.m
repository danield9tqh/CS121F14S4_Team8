//
//  MenuViewController.m
//  PowerUP
//
//  Created by Cyrus Huang on 10/26/14.
//  Copyright (c) 2014 CS121F14S4_Team8. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "LevelViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MenuViewController (){
    NSInteger _language; // 0 english, 1 spanish, 2 chinese
    AVAudioPlayer* _audioPlayerLanguagePressed;
    AVAudioPlayer* _audioPlayerAboutPressed;
    
    UISegmentedControl* _segmentControl;
    UIButton* _level;
    UIButton* _about;
}

@end

@implementation MenuViewController

- (id) initWithLanguage: (int) language {
    _language = language;
    [self viewDidLoad];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat frameWidth = self.view.frame.size.width;
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat buttonWidth = frameWidth / 2;
    CGFloat buttonHeight = buttonWidth / 3;
    
    // sound set up
    NSString *languagePath  = [[NSBundle mainBundle] pathForResource:@"beep-attention" ofType:@"aif"];
    NSURL *languagePathURL = [NSURL fileURLWithPath : languagePath];
    _audioPlayerLanguagePressed = [[AVAudioPlayer alloc] initWithContentsOfURL:languagePathURL error:nil];
    
    NSString *aboutPath  = [[NSBundle mainBundle] pathForResource:@"beep-horn" ofType:@"aif"];
    NSURL *aboutPathURL = [NSURL fileURLWithPath : aboutPath];
    _audioPlayerAboutPressed = [[AVAudioPlayer alloc] initWithContentsOfURL:aboutPathURL error:nil];
    
    // segemented control set up
    _segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"English",@"español",@"中文"]];
    
    _segmentControl.frame = CGRectMake((frameWidth - buttonWidth) / 2, (frameHeight - buttonHeight * 4) / 2, buttonWidth, buttonHeight / 2);
    [_segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [_segmentControl setSelectedSegmentIndex:0];
    [self.view addSubview:_segmentControl];
    
    // set up tint color
    UIColor* tintColor = [UIColor colorWithRed:0.0 green:128.0/255.0 blue:1.0 alpha:1.0];
    
    // level button set up
    CGRect levelFrame = CGRectMake((frameWidth - buttonWidth) / 2, (frameHeight - buttonHeight) / 2, buttonWidth, buttonHeight);
    _level = [[UIButton alloc] initWithFrame:levelFrame];
    
    [_level setBackgroundColor:[UIColor clearColor]];
    [_level setTitle:@"Start new game" forState:UIControlStateNormal];
    [_level setTitleColor:tintColor forState:UIControlStateNormal];
    
    [self.view addSubview:_level];

    [_level addTarget:self action:@selector(chooseLevel:) forControlEvents:UIControlEventTouchUpInside];

    // about button set up
    CGRect aboutFrame = CGRectMake((frameWidth - buttonWidth) / 2, (frameHeight + buttonHeight * 2) / 2, buttonWidth, buttonHeight);
    _about = [[UIButton alloc] initWithFrame:aboutFrame];
    
    [_about setBackgroundColor:[UIColor clearColor]];
    [_about setTitle:@"How to play" forState:UIControlStateNormal];
    [_about setTitleColor:tintColor forState:UIControlStateNormal];
    
    [self.view addSubview:_about];
    
    [_about addTarget:self action:@selector(displayHelpMessage:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)chooseLevel:(id)sender
{
    LevelViewController* levelVC = [[LevelViewController alloc] initWithLanguage:_language];
    [self presentViewController:levelVC animated:NO completion:nil];
}

-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    [_audioPlayerLanguagePressed prepareToPlay];
    [_audioPlayerLanguagePressed play];
    switch (segment.selectedSegmentIndex) {
        case 0:
            NSLog(@"english");
            _language = 0;
            [_level setTitle:@"Start new game" forState:UIControlStateNormal];
            [_about setTitle:@"How to play" forState:UIControlStateNormal];
            break;
            
        case 1:
            NSLog(@"spanish");
            [_level setTitle:@"Juego nuevo" forState:UIControlStateNormal];
            [_about setTitle:@"Instrucción" forState:UIControlStateNormal];
            _language = 1;
            break;
            
        case 2:
            NSLog(@"chinese");
            [_level setTitle:@"开始新游戏" forState:UIControlStateNormal];
            [_about setTitle:@"游戏指南" forState:UIControlStateNormal];
            _language = 2;
            break;
            
        default:
            break;
    }
}

- (void)displayHelpMessage:(id) sender{
    NSString *title;
    NSString *message;
    //[_audioPlayerAboutPressed prepareToPlay];
    //[_audioPlayerAboutPressed play];
    switch (_language) {
        case 0:
            title = @"How to Play";
            message = @"In this game, you want to connect the circuit and power up the bulb by clicking on switches to correct positions.";
            break;
        case 1:
            title = @"Instrucción";
            message = @"En ese juego, estás tratando de conectar la circuito y encender la bombilla haciendo clic en los interruptores a las posiciones correctas";
            break;
        case 2:
            title = @"游戏指南";
            message = @"在这个游戏中，你需要通过变换开关的位置使灯泡发亮。";
            break;
        default:
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
