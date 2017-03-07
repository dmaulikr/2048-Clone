//
//  ViewController.h
//  2048//
//  Created by Pravin Biradar on 1/27/17.
//  Copyright © 2017 Pravin Biradar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>
#import <CoreMotion/CoreMotion.h>


int randomNumber;
Boolean addNum = false;
NSInteger num;

@interface ViewController : UIViewController<SKTransactionDelegate>

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *boxes;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScore;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *mainBoard;

@property (weak, nonatomic) IBOutlet UIButton *replay;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *nameOfGame;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipeGestureRecognizer;


@property (weak, nonatomic) IBOutlet UIButton *motionBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopMotion;


@property (weak, nonatomic) IBOutlet UIButton *stopVoiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;


- (IBAction)startMotion:(id)sender;

- (IBAction)stopMotion:(id)sender;


- (IBAction)voiceAction:(id)sender;

- (IBAction)stopVoice:(id)sender;

- (IBAction)rePlay:(id)sender;

@end

