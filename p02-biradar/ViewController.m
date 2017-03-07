//
//  ViewController.m
//  2048
//
//  Created by Pravin Biradar on 1/27/17.
//  Copyright © 2017 Pravin Biradar. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SpeechKit/SpeechKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@end

@implementation ViewController
@protocol SKTransactionDelegate;
@synthesize boxes,replay,scoreLabel,score,nameOfGame,highScore,highScoreLabel,mainBoard,voiceLabel,voiceBtn,stopVoiceBtn,motionBtn,stopMotion,motionManager;
NSUserDefaults *HighScore;

static double accelX, accelY, accelZ;

- (void)viewDidLoad {
    [super viewDidLoad];
    stopMotion.hidden=true;
    stopVoiceBtn.hidden=true;
    HighScore = [NSUserDefaults standardUserDefaults];
    
    if([HighScore objectForKey:@"HighScore"]!= nil) {
        highScore.text = [HighScore objectForKey:@"HighScore"];
    }
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];

    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    self.upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    self.downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.upSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.downSwipeGestureRecognizer];

    
  
    

    
    //Random location of number 2 at the start of the game
    for (int i = 0; i < 16; i++) {
        NSInteger randomNumber = arc4random() % 16;
        
        if ([[[boxes objectAtIndex:randomNumber] text]  isEqual: @""]) {
            
            [[boxes objectAtIndex:randomNumber] setText:@"2" ];
            [UIView transitionWithView:[boxes objectAtIndex:randomNumber] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [[boxes objectAtIndex:randomNumber] setTextColor:[UIColor colorWithRed:(24/255.f) green:(24/255.f) blue:(24/255.f) alpha:1]];
                
                [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(200/255.f) alpha:1]];
                
                
                [[boxes objectAtIndex:randomNumber] setShadowColor:[UIColor blueColor]];
            } completion:nil];
            
            
            
            self.score.alpha = 0;
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
                self.score.alpha = 1;
            } completion:nil];
            
            break;
        }
        
        
    }
    
    
    //Random location of number 2 at the start of the game
    for (int i = 0; i < 16; i++) {
        NSInteger randomNumber = arc4random() % 16;
        
        if ([[[boxes objectAtIndex:randomNumber] text]  isEqual: @""]) {
            
            [[boxes objectAtIndex:randomNumber] setText:@"2" ];
            [UIView transitionWithView:[boxes objectAtIndex:randomNumber] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [[boxes objectAtIndex:randomNumber] setTextColor:[UIColor colorWithRed:(24/255.f) green:(24/255.f) blue:(24/255.f) alpha:1]];
                
                [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(200/255.f) alpha:1]];
                
                
                [[boxes objectAtIndex:randomNumber] setShadowColor:[UIColor blueColor]];
            } completion:nil];
            
            
            
            self.score.alpha = 0;
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
                self.score.alpha = 1;
            } completion:nil];
            break;
        }
        
        
    }
    
    
}

static SKTransaction *currentTransaction = nil;
//static SKSession  *currentSession = nil;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)voiceAction:(id)sender {
    voiceBtn.hidden= true;
    stopVoiceBtn.hidden=false;
    self.voiceLabel.hidden = false;
    
    
    SKSession* session = [[SKSession alloc] initWithURL:[NSURL URLWithString:@"nmsps://NMDPTRIAL_pravin_biradar01_gmail_com20170129175618@sslsandbox-nmdp.nuancemobility.net:443"] appToken:@"d49a9f604f9d12f774266755d7f53aa9729bcd70ba1eedfef4e0b0c301fe4dd698ec36e88949dffd6f4652473b8cf0ad27bd1ee2dc0be0d0eb9093ed8fe1c327"];
    
    SKTransaction *transaction = [session recognizeWithType:SKTransactionSpeechTypeDictation
                     detection:SKTransactionEndOfSpeechDetectionShort
                      language:@"eng-IND"
                      //language:@"hin-IND"
                      //language:@"eng-USA"
                      delegate:self];
    currentTransaction = transaction;
    }

- (void)transactionDidBeginRecording:(SKTransaction *)transaction {
    
        //currentTransaction = transaction;
}


- (void)transactionDidFinishRecording:(SKTransaction *)transaction {
    
        //[currentTransaction stopRecording];
    
}

- (void)transaction:(SKTransaction *)transaction didFinishWithSuggestion:(NSString *)suggestion {
    
    [self voiceAction:self];
    
}

- (void)transaction:(SKTransaction *)transaction didFailWithError:(NSError *)error
suggestion:(NSString *)suggestion {
    
    [self voiceAction:self];
    
}


- (IBAction)stopVoice:(id)sender  {
    stopVoiceBtn.hidden=true;
    voiceBtn.hidden=false;
    self.voiceLabel.hidden = true;
    
    //[currentTransaction cancel ];
    //[self transactionDidFinishRecording:(SKTransaction *)transaction];
    
}

- (IBAction)startMotion:(id)sender {
    motionBtn.hidden=true;
    stopMotion.hidden=false;
    motionManager = [[CMMotionManager alloc] init];
    //    if (motionManager.accelerometerActive && motionManager.accelerometerAvailable){
    
    motionManager.accelerometerUpdateInterval = 0.8;
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        CMAcceleration acceleration = [accelerometerData acceleration];
        double dx,dy,dz;
        dx = fabs(acceleration.x - accelX);
        dy = fabs(acceleration.y - accelY);
        dz = fabs(acceleration.z - accelZ);
        
        
//        NSLog(@"X =          %0.4f",acceleration.x );
//        NSLog(@"Y = %0.4f",acceleration.y );
//        NSLog(@"Z = %0.4f",acceleration.z );
        
        
        accelX = acceleration.x;
        accelY = acceleration.y;
        accelZ = acceleration.z;
        
        if (accelX < -0.9 )
        {
            [self performSelectorOnMainThread:@selector(goLeft) withObject:NULL waitUntilDone:NO];
        }
        
        else if (accelX > 0.9)
        {
            [self performSelectorOnMainThread:@selector(goRight) withObject:NULL waitUntilDone:NO];
        }
        else if (accelZ < -0.9  )
        {
            [self performSelectorOnMainThread:@selector(goUp) withObject:NULL waitUntilDone:NO];
        }
        else if (accelZ > 0.9 )
        {
            [self performSelectorOnMainThread:@selector(goDown) withObject:NULL waitUntilDone:NO];
        }
        
    }];
    
}

- (IBAction)stopMotion:(id)sender {
    stopMotion.hidden=true;
    motionBtn.hidden=false;
    
    [motionManager stopAccelerometerUpdates];
}


- (void) goLeft{
    {
        
        //making boxes go left
        addNum = false;
        int lft = 0;
        while (lft <= 12) {
            
            //checking first column
            if ([[[boxes objectAtIndex:lft] text] isEqual:@""]) {
                [[boxes objectAtIndex:lft] setText:[[boxes objectAtIndex:(lft+1)] text]];
                [[boxes objectAtIndex:(lft+1)] setText:@""];
                [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
                
            }
            
            //checking 2nd column
            if([[[boxes objectAtIndex:(lft+1)] text] isEqual:@""])
            {
                if([[[boxes objectAtIndex:lft] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:lft] setText:[[boxes objectAtIndex:lft+2] text]];
                    [[boxes objectAtIndex:(lft+2)] setText:@""];
                    [[boxes objectAtIndex:(lft+2)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else
                {
                    [[boxes objectAtIndex:(lft+1)] setText:[[boxes objectAtIndex:lft+2] text]];
                    [[boxes objectAtIndex:(lft+2)] setText:@""];
                    [[boxes objectAtIndex:(lft+2)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
            }
            
            //checking 3rd column
            if([[[boxes objectAtIndex:(lft+2)] text] isEqual:@""])
            {
                if([[[boxes objectAtIndex:lft] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:lft] setText:[[boxes objectAtIndex:lft+3] text]];
                    [[boxes objectAtIndex:(lft+3)] setText:@""];
                    [[boxes objectAtIndex:(lft+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else if([[[boxes objectAtIndex:(lft+1)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+1)] setText:[[boxes objectAtIndex:lft+3] text]];
                    [[boxes objectAtIndex:(lft+3)] setText:@""];
                    [[boxes objectAtIndex:(lft+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else
                {
                    [[boxes objectAtIndex:(lft+2)] setText:[[boxes objectAtIndex:lft+3] text]];
                    [[boxes objectAtIndex:(lft+3)] setText:@""];
                    [[boxes objectAtIndex:(lft+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
            }
            lft = lft + 4;
        }
        
        
        //addition logic
        int k = 0;
        while(k<=12)
        {
            if ([[[boxes objectAtIndex:k] text] isEqualToString:[[boxes objectAtIndex:(k+1)] text]]) {
                
                int m = [[[boxes objectAtIndex:k] text] intValue];
                int n = [[[boxes objectAtIndex:(k+1)] text] intValue];
                int res = m + n;
                
                if(res > 0)
                {
                    [[boxes objectAtIndex:k] setText :[NSString stringWithFormat:@"%d",res] ];
                    int p = [score.text intValue];
                    int scr = p + res;
                    [score setText:[NSString stringWithFormat:@"%d",scr]];
                    
                    if ([[score text]intValue] >= [[highScore text]intValue]) {
                        [highScore setText:[score text]];
                    }
                    
                    //emptying the 2nd box
                    [[boxes objectAtIndex:(k+1)] setText:@""];
                    [[boxes objectAtIndex:(k+1)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            
            //adding 2nd and 3rd column
            if ([[[boxes objectAtIndex:(k+1)] text] isEqualToString:[[boxes objectAtIndex:(k+2)] text]]) {
                
                int m = [[[boxes objectAtIndex:(k+1)] text] intValue];
                int n = [[[boxes objectAtIndex:(k+2)] text] intValue];
                int res = m + n;
                
                if(res > 0)
                {
                    [[boxes objectAtIndex:(k+1)] setText :[NSString stringWithFormat:@"%d",res] ];
                    int p = [score.text intValue];
                    int scr = p + res;
                    [score setText:[NSString stringWithFormat:@"%d",scr]];
                    
                    if ([[score text]intValue] >= [[highScore text]intValue]) {
                        [highScore setText:[score text]];
                    }
                    
                    
                    //emptying the 2nd tile
                    [[boxes objectAtIndex:(k+2)] setText:@""];
                    [[boxes objectAtIndex:(k+2)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            
            //adding 3rd and 4th column
            if ([[[boxes objectAtIndex:(k+2)] text] isEqualToString:[[boxes objectAtIndex:(k+3)] text]]) {
                
                int m = [[[boxes objectAtIndex:(k+2)] text] intValue];
                int n = [[[boxes objectAtIndex:(k+3)] text] intValue];
                int res = m + n;
                
                if(res > 0)
                {
                    [[boxes objectAtIndex:(k+2)] setText :[NSString stringWithFormat:@"%d",res] ];
                    int p = [score.text intValue];
                    int scr = p + res;
                    [score setText:[NSString stringWithFormat:@"%d",scr]];
                    
                    if ([[score text]intValue] >= [[highScore text]intValue]) {
                        [highScore setText:[score text]];
                    }
                    
                    //emptying the 2nd tile
                    [[boxes objectAtIndex:(k+3)] setText:@""];
                    [[boxes objectAtIndex:(k+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            
            k = k + 4;
        }
        
        //making boxes go left
        lft = 0;
        while (lft <= 12) {
            
            //checking first column
            if ([[[boxes objectAtIndex:lft] text] isEqual:@""]) {
                [[boxes objectAtIndex:lft] setText:[[boxes objectAtIndex:(lft+1)] text]];
                [[boxes objectAtIndex:(lft+1)] setText:@""];
                [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            
            //checking 2nd column
            if([[[boxes objectAtIndex:(lft+1)] text] isEqual:@""])
            {
                if([[[boxes objectAtIndex:lft] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:lft] setText:[[boxes objectAtIndex:lft+2] text]];
                    [[boxes objectAtIndex:(lft+2)] setText:@""];
                    [[boxes objectAtIndex:(lft+2)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else
                {
                    [[boxes objectAtIndex:(lft+1)] setText:[[boxes objectAtIndex:lft+2] text]];
                    [[boxes objectAtIndex:(lft+2)] setText:@""];
                    [[boxes objectAtIndex:(lft+2)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
            }
            
            //checking 3rd column
            if([[[boxes objectAtIndex:(lft+2)] text] isEqual:@""])
            {
                if([[[boxes objectAtIndex:lft] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:lft] setText:[[boxes objectAtIndex:lft+3] text]];
                    [[boxes objectAtIndex:(lft+3)] setText:@""];
                    [[boxes objectAtIndex:(lft+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else if([[[boxes objectAtIndex:(lft+1)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+1)] setText:[[boxes objectAtIndex:lft+3] text]];
                    [[boxes objectAtIndex:(lft+3)] setText:@""];
                    [[boxes objectAtIndex:(lft+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else
                {
                    [[boxes objectAtIndex:(lft+2)] setText:[[boxes objectAtIndex:lft+3] text]];
                    [[boxes objectAtIndex:(lft+3)] setText:@""];
                    [[boxes objectAtIndex:(lft+3)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
            }
            lft = lft + 4;
        }
        
        //adding a random 2
        [self generatingNum];
        
        
    }



}

- (void)goRight{
        //making boxes go right
        int lft = 0;
        while (lft <= 12) {
            
            //checking first column
            if ([[[boxes objectAtIndex:(lft+3)] text] isEqual:@""]) {
                [[boxes objectAtIndex:(lft+3)] setText:[[boxes objectAtIndex:(lft+2)] text]];
                [[boxes objectAtIndex:(lft+2)] setText:@""];
                [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
                
            }
            
            //checking 2nd column
            if([[[boxes objectAtIndex:(lft+2)] text] isEqual:@""])
            {
                if([[[boxes objectAtIndex:(lft+3)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+3)] setText:[[boxes objectAtIndex:lft+1] text]];
                    [[boxes objectAtIndex:(lft+1)] setText:@""];
                    [[boxes objectAtIndex:(lft+1)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
                else
                {
                    [[boxes objectAtIndex:(lft+2)] setText:[[boxes objectAtIndex:lft+1] text]];
                    [[boxes objectAtIndex:(lft+1)] setText:@""];
                    [[boxes objectAtIndex:(lft+1)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                    addNum = true;
                }
            }
            
            //checking 3rd column
            if([[[boxes objectAtIndex:(lft+1)] text] isEqual:@""])
            {
                addNum = true;
                if([[[boxes objectAtIndex:(lft+3)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+3)] setText:[[boxes objectAtIndex:lft] text]];
                    [[boxes objectAtIndex:(lft)] setText:@""];
                    [[boxes objectAtIndex:(lft)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
                else if([[[boxes objectAtIndex:(lft+2)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+2)] setText:[[boxes objectAtIndex:lft] text]];
                    [[boxes objectAtIndex:(lft)] setText:@""];
                    [[boxes objectAtIndex:(lft)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
                else
                {
                    [[boxes objectAtIndex:(lft+1)] setText:[[boxes objectAtIndex:lft] text]];
                    [[boxes objectAtIndex:(lft)] setText:@""];
                    [[boxes objectAtIndex:(lft)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            lft = lft + 4;
        }
        
        
        
        //addition logic
        int k = 0;
        while(k<=12)
        {
            if ([[[boxes objectAtIndex:(k+3)] text] isEqualToString:[[boxes objectAtIndex:(k+2)] text]]) {
                
                int m = [[[boxes objectAtIndex:(k+3)] text] intValue];
                int n = [[[boxes objectAtIndex:(k+2)] text] intValue];
                int res = m + n;
                
                if(res > 0)
                {
                    [[boxes objectAtIndex:(k+3)] setText :[NSString stringWithFormat:@"%d",res] ];
                    int p = [score.text intValue];
                    int scr = p + res;
                    [score setText:[NSString stringWithFormat:@"%d",scr]];
                    
                    if ([[score text]intValue] >= [[highScore text]intValue]) {
                        [highScore setText:[score text]];
                    }
                    
                    //emptying the 2nd tile
                    [[boxes objectAtIndex:(k+2)] setText:@""];
                    [[boxes objectAtIndex:(k+2)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            
            //adding 2nd and 3rd column
            if ([[[boxes objectAtIndex:(k+2)] text] isEqualToString:[[boxes objectAtIndex:(k+1)] text]]) {
                
                int m = [[[boxes objectAtIndex:(k+2)] text] intValue];
                int n = [[[boxes objectAtIndex:(k+1)] text] intValue];
                int res = m + n;
                
                if(res > 0)
                {
                    [[boxes objectAtIndex:(k+2)] setText :[NSString stringWithFormat:@"%d",res] ];
                    int p = [score.text intValue];
                    int scr = p + res;
                    [score setText:[NSString stringWithFormat:@"%d",scr]];
                    
                    if ([[score text]intValue] >= [[highScore text]intValue]) {
                        [highScore setText:[score text]];
                    }
                    
                    //emptying the 2nd tile
                    [[boxes objectAtIndex:(k+1)] setText:@""];
                    [[boxes objectAtIndex:(k+1)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            
            //adding 3rd and 4th column
            if ([[[boxes objectAtIndex:(k+1)] text] isEqualToString:[[boxes objectAtIndex:(k)] text]]) {
                
                int m = [[[boxes objectAtIndex:(k+1)] text] intValue];
                int n = [[[boxes objectAtIndex:(k)] text] intValue];
                int res = m + n;
                
                if(res > 0)
                {
                    [[boxes objectAtIndex:(k+1)] setText :[NSString stringWithFormat:@"%d",res] ];
                    int p = [score.text intValue];
                    int scr = p + res;
                    [score setText:[NSString stringWithFormat:@"%d",scr]];
                    
                    if ([[score text]intValue] >= [[highScore text]intValue]) {
                        [highScore setText:[score text]];
                    }
                    
                    //emptying the 2nd tile
                    [[boxes objectAtIndex:(k)] setText:@""];
                    [[boxes objectAtIndex:(k)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
                
            }
            
            k = k + 4;
        }
        
        lft = 0;
        while (lft <= 12) {
            
            //checking first column
            if ([[[boxes objectAtIndex:(lft+3)] text] isEqual:@""]) {
                [[boxes objectAtIndex:(lft+3)] setText:[[boxes objectAtIndex:(lft+2)] text]];
                [[boxes objectAtIndex:(lft+2)] setText:@""];
                [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            
            //checking 2nd column
            if([[[boxes objectAtIndex:(lft+2)] text] isEqual:@""])
            {
                addNum = true;
                if([[[boxes objectAtIndex:(lft+3)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+3)] setText:[[boxes objectAtIndex:lft+1] text]];
                    [[boxes objectAtIndex:(lft+1)] setText:@""];
                    [[boxes objectAtIndex:(lft+1)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
                else
                {
                    [[boxes objectAtIndex:(lft+2)] setText:[[boxes objectAtIndex:lft+1] text]];
                    [[boxes objectAtIndex:(lft+1)] setText:@""];
                    [[boxes objectAtIndex:(lft+1)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            
            //checking 3rd column
            if([[[boxes objectAtIndex:(lft+1)] text] isEqual:@""])
            {
                addNum = true;
                if([[[boxes objectAtIndex:(lft+3)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+3)] setText:[[boxes objectAtIndex:lft] text]];
                    [[boxes objectAtIndex:(lft)] setText:@""];
                    [[boxes objectAtIndex:(lft)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
                else if([[[boxes objectAtIndex:(lft+2)] text] isEqual:@""])
                {
                    [[boxes objectAtIndex:(lft+2)] setText:[[boxes objectAtIndex:lft] text]];
                    [[boxes objectAtIndex:(lft)] setText:@""];
                    [[boxes objectAtIndex:(lft)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
                else
                {
                    [[boxes objectAtIndex:(lft+1)] setText:[[boxes objectAtIndex:lft] text]];
                    [[boxes objectAtIndex:(lft)] setText:@""];
                    [[boxes objectAtIndex:(lft)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                }
            }
            lft = lft + 4;
        }
        
        //adding a random 2
        [self generatingNum];
        
}


- (void)goUp
{
    //Stage 1 - get all the location closer
    for (int j=0; j<=3; j++) {
        
        //this is for location 0,1,2,3
        if([[[boxes objectAtIndex:j] text] isEqual:@""])
        {
            [[boxes objectAtIndex:j] setText: [[boxes objectAtIndex:(j+4)] text]];
            [[boxes objectAtIndex:(j+4)] setText: @""];
        }
        
        //this is for location 4,5,6,7
        if([[[boxes objectAtIndex:j+4] text] isEqual:@""])
        {
            if([[[boxes objectAtIndex:j] text] isEqual:@""])
            {
                [[boxes objectAtIndex:j] setText: [[boxes objectAtIndex:(j+8)] text]];
                [[boxes objectAtIndex:(j+8)] setText: @""];
            }
            else
            {
                [[boxes objectAtIndex:j+4] setText: [[boxes objectAtIndex:(j+8)] text]];
                [[boxes objectAtIndex:(j+8)] setText: @""];
            }
            
        }
        
        //this is for location 8,9,10,11
        if([[[boxes objectAtIndex:j+8] text] isEqual:@""])
        {
            if([[[boxes objectAtIndex:j] text] isEqual:@""])
            {
                [[boxes objectAtIndex:j] setText: [[boxes objectAtIndex:(j+12)] text]];
                [[boxes objectAtIndex:(j+12)] setText: @""];
                
            }
            else if([[[boxes objectAtIndex:j+4] text] isEqual:@""])
            {
                [[boxes objectAtIndex:j+4] setText: [[boxes objectAtIndex:(j+12)] text]];
                [[boxes objectAtIndex:(j+12)] setText: @""];
            }
            else
            {
                [[boxes objectAtIndex:j+8] setText: [[boxes objectAtIndex:(j+12)] text]];
                [[boxes objectAtIndex:(j+12)] setText: @""];
            }
            
        }
    }
    
    //Stage 2 - add consecutive numbers in pairs.
    int k = 0;
    while(k<=11)
    {
        
        if ([[[boxes objectAtIndex:k] text] isEqualToString:[[boxes objectAtIndex:(k+4)] text]]) {
            int m = [[[boxes objectAtIndex:k] text] intValue];
            int n = [[[boxes objectAtIndex:(k+4)] text] intValue];
            int res = m + n;
            if(res > 0)
            {
                //setting the added value
                [[boxes objectAtIndex:k] setText :[NSString stringWithFormat:@"%d",res] ];
                //emptying the 2nd tile
                [[boxes objectAtIndex:(k+4)] setText:@""];
                //calculating score
                int p = [score.text intValue];
                int scr = p + res;
                [score setText:[NSString stringWithFormat:@"%d",scr]];
                
                if ([[score text]intValue] >= [[highScore text]intValue]) {
                    [highScore setText:[score text]];
                }
            }
            
        }
        
        k++;
    }
    
    
    //Stage 3 - move and remove empty space.
    for (int j=0; j<=3; j++) {
        
        //this is for location 0,1,2,3
        if([[[boxes objectAtIndex:j] text] isEqual:@""])
        {
            [[boxes objectAtIndex:j] setText: [[boxes objectAtIndex:(j+4)] text]];
            [[boxes objectAtIndex:(j+4)] setText: @""];
            
        }
        
        //this is for location 4,5,6,7
        if([[[boxes objectAtIndex:j+4] text] isEqual:@""])
        {
            if([[[boxes objectAtIndex:j] text] isEqual:@""])
            {
                [[boxes objectAtIndex:j] setText: [[boxes objectAtIndex:(j+8)] text]];
                [[boxes objectAtIndex:(j+8)] setText: @""];
            }
            else
            {
                [[boxes objectAtIndex:j+4] setText: [[boxes objectAtIndex:(j+8)] text]];
                [[boxes objectAtIndex:(j+8)] setText: @""];
            }
            
        }
        
        //this is for location 8,9,10,11
        if([[[boxes objectAtIndex:j+8] text] isEqual:@""])
        {
            if([[[boxes objectAtIndex:j] text] isEqual:@""])
            {
                [[boxes objectAtIndex:j] setText: [[boxes objectAtIndex:(j+12)] text]];
                [[boxes objectAtIndex:(j+12)] setText: @""];
                
            }
            else if([[[boxes objectAtIndex:j+4] text] isEqual:@""])
            {
                [[boxes objectAtIndex:j+4] setText: [[boxes objectAtIndex:(j+12)] text]];
                [[boxes objectAtIndex:(j+12)] setText: @""];
            }
            else
            {
                [[boxes objectAtIndex:j+8] setText: [[boxes objectAtIndex:(j+12)] text]];
                [[boxes objectAtIndex:(j+12)] setText: @""];
            }
            
        }
    }
    
    //adding a random 2
    [self generatingNum];
    
}

- (void)goDown
{
    
    addNum = false;
    //making boxes go down
    for(int dwn = 0;dwn < 4 ; dwn++)
    {
        //chking last row of columns
        if ([[[boxes objectAtIndex:(dwn+12)] text] isEqual:@""]) {
            [[boxes objectAtIndex:(dwn+12)] setText:[[boxes objectAtIndex:(dwn+8)] text]];
            [[boxes objectAtIndex:(dwn+8)] setText:@""];
            [[boxes objectAtIndex:(dwn+8)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
            addNum = true;
        }
        //checking 2nd last row of columns
        if([[[boxes objectAtIndex:(dwn+8)] text] isEqual:@""])
        {
            if ([[[boxes objectAtIndex:(dwn+12)] text] isEqual:@""]) {
                [[boxes objectAtIndex:(dwn+12)] setText:[[boxes objectAtIndex:(dwn+4)] text]];
                [[boxes objectAtIndex:(dwn+4)] setText:@""];
                [[boxes objectAtIndex:(dwn+4)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            else
            {
                [[boxes objectAtIndex:(dwn+8)] setText:[[boxes objectAtIndex:(dwn+4)] text]];
                [[boxes objectAtIndex:(dwn+4)] setText:@""];
                [[boxes objectAtIndex:(dwn+4)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
                
            }
        }
        //checking 2nd row of column
        if([[[boxes objectAtIndex:(dwn+4)] text] isEqual:@""])
        {
            if ([[[boxes objectAtIndex:(dwn+12)] text] isEqual:@""]) {
                [[boxes objectAtIndex:(dwn+12)] setText:[[boxes objectAtIndex:(dwn)] text]];
                [[boxes objectAtIndex:(dwn)] setText:@""];
                [[boxes objectAtIndex:(dwn)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            else if ([[[boxes objectAtIndex:(dwn+8)] text] isEqual:@""])
            {
                [[boxes objectAtIndex:(dwn+8)] setText:[[boxes objectAtIndex:(dwn)] text]];
                [[boxes objectAtIndex:(dwn)] setText:@""];
                [[boxes objectAtIndex:(dwn)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            else
            {
                [[boxes objectAtIndex:(dwn+4)] setText:[[boxes objectAtIndex:(dwn)] text]];
                [[boxes objectAtIndex:(dwn)] setText:@""];
                [[boxes objectAtIndex:(dwn)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
                
            }
        }
    }
    
    
    //addition logic
    int k = 15;
    while(k>=4)
    {
        if ([[[boxes objectAtIndex:k] text] isEqualToString:[[boxes objectAtIndex:(k-4)] text]]) {
            
            
            int m = [[[boxes objectAtIndex:k] text] intValue];
            int n = [[[boxes objectAtIndex:(k-4)] text] intValue];
            int res = m + n;
            
            if(res > 0)
            {
                
                [[boxes objectAtIndex:k] setText :[NSString stringWithFormat:@"%d",res] ];
                int p = [score.text intValue];
                int scr = p + res;
                [score setText:[NSString stringWithFormat:@"%d",scr]];
                
                if ([[score text]intValue] >= [[highScore text]intValue]) {
                    [highScore setText:[score text]];
                }
                
                //emptying the 2nd tile
                [[boxes objectAtIndex:(k-4)] setText:@""];
                [[boxes objectAtIndex:(k-4)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
            }
            
        }
        
        k--;
    }
    
    
    //making boxes go down
    for(int dwn = 0;dwn < 4 ; dwn++)
    {
        //chking last row of columns
        if ([[[boxes objectAtIndex:(dwn+12)] text] isEqual:@""]) {
            [[boxes objectAtIndex:(dwn+12)] setText:[[boxes objectAtIndex:(dwn+8)] text]];
            [[boxes objectAtIndex:(dwn+8)] setText:@""];
            [[boxes objectAtIndex:(dwn+8)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
            addNum = true;
        }
        //checking 2nd last row of columns
        if([[[boxes objectAtIndex:(dwn+8)] text] isEqual:@""])
        {
            if ([[[boxes objectAtIndex:(dwn+12)] text] isEqual:@""]) {
                [[boxes objectAtIndex:(dwn+12)] setText:[[boxes objectAtIndex:(dwn+4)] text]];
                [[boxes objectAtIndex:(dwn+4)] setText:@""];
                [[boxes objectAtIndex:(dwn+4)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            else
            {
                [[boxes objectAtIndex:(dwn+8)] setText:[[boxes objectAtIndex:(dwn+4)] text]];
                [[boxes objectAtIndex:(dwn+4)] setText:@""];
                [[boxes objectAtIndex:(dwn+4)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
                
            }
        }
        //checking 2nd row of column
        if([[[boxes objectAtIndex:(dwn+4)] text] isEqual:@""])
        {
            if ([[[boxes objectAtIndex:(dwn+12)] text] isEqual:@""]) {
                [[boxes objectAtIndex:(dwn+12)] setText:[[boxes objectAtIndex:(dwn)] text]];
                [[boxes objectAtIndex:(dwn)] setText:@""];
                [[boxes objectAtIndex:(dwn)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            else if ([[[boxes objectAtIndex:(dwn+8)] text] isEqual:@""])
            {
                [[boxes objectAtIndex:(dwn+8)] setText:[[boxes objectAtIndex:(dwn)] text]];
                [[boxes objectAtIndex:(dwn)] setText:@""];
                [[boxes objectAtIndex:(dwn)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
            }
            else
            {
                [[boxes objectAtIndex:(dwn+4)] setText:[[boxes objectAtIndex:(dwn)] text]];
                [[boxes objectAtIndex:(dwn)] setText:@""];
                [[boxes objectAtIndex:(dwn)] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
                addNum = true;
                
            }
        }
    }
    
    //adding a random 2
    [self generatingNum];
    
}

- (void)transaction:(SKTransaction *)transaction didReceiveRecognition:(SKRecognition *)recognition {
    [voiceLabel setText: [recognition text]];
    if ([[voiceLabel text] isEqualToString:@"Go left"]){
        [self goLeft];
    
    }
    
    if ([[voiceLabel text] isEqualToString:@"Go right"])
    {
        [self goRight];
    
    }
    if ([[voiceLabel text] isEqualToString:@"Go up"])
    {
        [self goUp];
    }
    
    if ([[voiceLabel text] isEqualToString:@"Go down"])
    {
        [self goDown];
    }
        
    HighScore = [NSUserDefaults standardUserDefaults];
    [HighScore setObject:[highScore text] forKey: @"HighScore"];
    [HighScore synchronize];
    
    
    
    if ([[score text]intValue] >30) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(230/255.f) green:(230/255.f) blue:(230/255.f) alpha:1]];
    }
    
    if ([[score text]intValue] >=30 && [[score text]intValue] <70) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(204/255.f) green:(204/255.f) blue:(204/255.f) alpha:1]];
    }
    
    else if ([[score text]intValue] >=70 && [[score text]intValue] <100) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(179/255.f) green:(179/255.f) blue:(179/255.f) alpha:1]];
    }
    
    else if ([[score text]intValue] >=100 && [[score text]intValue] <400) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(153/255.f) green:(153/255.f) blue:(153/255.f) alpha:1]];
    }
    else if ([[score text]intValue] >=400 && [[score text]intValue] <800) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(128/255.f) green:(128/255.f) blue:(128/255.f) alpha:1]];
    }
    
    else if ([[score text]intValue] >=800 && [[score text]intValue] <1600) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(102/255.f) green:(102/255.f) blue:(102/255.f) alpha:1]];
    }
    else if ([[score text]intValue] >=1600 && [[score text]intValue] <3200) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(76/255.f) green:(76/255.f) blue:(76/255.f) alpha:1]];
    }
    else if ([[score text]intValue] >3200) {
        
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(51/255.f) green:(51/255.f) blue:(51/255.f) alpha:1]];
    }

}



- (IBAction)rePlay:(id)sender {
    
    //Restart the Game
    for(int m = 0 ; m <=15; m++)
    {
        [[boxes objectAtIndex:m] setText:@""];
        [[boxes objectAtIndex:m] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
    }
    //reset the score
    [score setText:@"0"];
    
    
    //add random 2
    for (int i = 0; i < 999; i++) {
        NSInteger randomNumber = arc4random() % 16;
        
        if ([[[boxes objectAtIndex:randomNumber] text]  isEqual: @""]) {
            
            [[boxes objectAtIndex:randomNumber] setText:@"2" ];
            [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(200/255.f) alpha:1]];
            
            break;
        }
    }
    [self generatingNum];

}


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    
    
    if ((sender.direction == UISwipeGestureRecognizerDirectionLeft) || ([[voiceLabel text] isEqualToString:@"Go left"]))
    {
        [self goLeft];
    
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight || [[voiceLabel text] isEqualToString:@"Go right"])
    {
        
        [self goRight];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionUp || [[voiceLabel text] isEqualToString:@"Go up"])
    {
        [self goUp];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionDown || [[voiceLabel text] isEqualToString:@"Go down"])
    {
        
        [self goDown];
    }

    HighScore = [NSUserDefaults standardUserDefaults];
    [HighScore setObject:[highScore text] forKey: @"HighScore"];
    [HighScore synchronize];
    
    
    
    if ([[score text]intValue] >30) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(230/255.f) green:(230/255.f) blue:(230/255.f) alpha:1]];
    }
    
    if ([[score text]intValue] >=30 && [[score text]intValue] <70) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(204/255.f) green:(204/255.f) blue:(204/255.f) alpha:1]];
    }
    
    else if ([[score text]intValue] >=70 && [[score text]intValue] <100) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(179/255.f) green:(179/255.f) blue:(179/255.f) alpha:1]];
    }
    
    else if ([[score text]intValue] >=100 && [[score text]intValue] <400) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(153/255.f) green:(153/255.f) blue:(153/255.f) alpha:1]];
    }
    else if ([[score text]intValue] >=400 && [[score text]intValue] <800) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(128/255.f) green:(128/255.f) blue:(128/255.f) alpha:1]];
    }
    
    else if ([[score text]intValue] >=800 && [[score text]intValue] <1600) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(102/255.f) green:(102/255.f) blue:(102/255.f) alpha:1]];
    }
    else if ([[score text]intValue] >=1600 && [[score text]intValue] <3200) {
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(76/255.f) green:(76/255.f) blue:(76/255.f) alpha:1]];
    }
    else if ([[score text]intValue] >3200) {
        
        [mainBoard setBackgroundColor:[UIColor colorWithRed:(51/255.f) green:(51/255.f) blue:(51/255.f) alpha:1]];
    }
    
}

-(void)generatingNum{
   
    int count = 0;
    Boolean go_flg = false;;
    //checking for gammeOver
    for (int go=0; go<=11; go++)
    {
        count++;
        if([[[boxes objectAtIndex:go] text] isEqual:@""])
        {
            go_flg = true;
        }
        else
        {
            if((count%4) == 0)
            {
                if([[[boxes objectAtIndex:go] text] isEqualToString:[[boxes objectAtIndex:(go+4)] text]])
                {
                    go_flg = true;
                }
            }
            else
            {
                if([[[boxes objectAtIndex:go] text] isEqualToString:[[boxes objectAtIndex:(go+1)] text]])
                {
                    go_flg = true;
                }
                else if([[[boxes objectAtIndex:go] text] isEqualToString:[[boxes objectAtIndex:(go+4)] text]])
                {
                    go_flg = true;
                }
            }
            
            if(go == 11)
            {
                if([[[boxes objectAtIndex:12] text] isEqualToString:[[boxes objectAtIndex:13] text]])
                {
                    go_flg = true;
                }
                else if([[[boxes objectAtIndex:13] text] isEqualToString:[[boxes objectAtIndex:14] text]])
                {
                    go_flg = true;
                }
                else if([[[boxes objectAtIndex:14] text] isEqualToString:[[boxes objectAtIndex:15] text]])
                {
                    go_flg = true;
                }
            }
        }
        
        if(go_flg)
            break;
    }
    
    if(go_flg)
    {
        
        NSMutableArray *myArray = [NSMutableArray array];
        [myArray removeAllObjects];
        for(int i = 0; i <= 15; i++) {
            if([[[boxes objectAtIndex:i] text] isEqual:@""])
            {
                [myArray addObject:[NSNumber numberWithInt:i]];
            }
        }
        
        if([myArray count] != 0)
        {
            
            num = [[myArray objectAtIndex:arc4random_uniform((int)[myArray count])] intValue];
            
            if([[[boxes objectAtIndex:num] text] isEqual:@""])
            {
                
                NSInteger randomNumber = arc4random() % 10;
                if(randomNumber == 7)
                {
                    [[boxes objectAtIndex:num] setText: @"4"];
                    [UIView transitionWithView:[boxes objectAtIndex:randomNumber] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:randomNumber] setTextColor:[UIColor whiteColor]];
                        [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor orangeColor]];
                        
                        [[boxes objectAtIndex:randomNumber] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                else
                {
                    [[boxes objectAtIndex:num] setText: @"2"];
                    [UIView transitionWithView:[boxes objectAtIndex:randomNumber] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:randomNumber] setTextColor:[UIColor whiteColor]];
                        [[boxes objectAtIndex:randomNumber] setBackgroundColor:[UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(200/255.f) alpha:1]];
                        
                        [[boxes objectAtIndex:randomNumber] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                
                
                
            }
            [myArray removeAllObjects];
        }
        for(int t = 0;t<=15;t++)
        {
            if([[[boxes objectAtIndex:t] text] isEqual:@"2048"])
            {
                
                
                if (!UIAccessibilityIsReduceTransparencyEnabled()) {
                    self.view.backgroundColor = [UIColor clearColor];
                    
                    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                    blurEffectView.frame = self.view.bounds;
                    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                    [self.view addSubview:blurEffectView];
                    
                    
                    
                    
                    
                    ///additonal
                    // Vibrancy effect
                    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
                    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
                    [vibrancyEffectView setFrame:self.view.bounds];
                    
                    // Label for vibrant text
                    UILabel *vibrantLabel = [[UILabel alloc] init];
                    UIButton *vibrantButton = [[UIButton alloc] init];
                    
                    [vibrantLabel setText:@"Congragulations, You Did it"];
                    [vibrantLabel setFont:[UIFont systemFontOfSize:20.0f]];
                    [vibrantLabel sizeToFit];
                    [vibrantLabel setCenter: self.view.center];
                    
                    
                    [vibrantButton setTitle:@"Re-play" forState:UIControlStateNormal];
                    // Add label to the vibrancy view
                    [[vibrancyEffectView contentView] addSubview:vibrantLabel];
                    
                    // Add the vibrancy view to the blur view
                    [[blurEffectView contentView] addSubview:vibrancyEffectView];
                }
                
                else {
                    self.view.backgroundColor = [UIColor blackColor];
                }
            }
            
            
        }
        
        //adding font and shadows
        UIFont *newFont = [UIFont fontWithName:@"Futura Medium" size:17];
        [boxes setValue:newFont forKey:@"font"];
        
        
        for(int lb = 0; lb <=15;lb++)
        {
            if([[[boxes objectAtIndex:lb] text] isEqual:@""])
            {
            }
            else
            {
                [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    [[boxes objectAtIndex:lb] setTextColor:[UIColor whiteColor]];
                    [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor orangeColor]];
                    
                    [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                } completion:nil];
                
                
                
            }
        }
        
        
        ///adding colors to boxes
        for(int lb = 0; lb <=15;lb++)
        {
            if([[[boxes objectAtIndex:lb] text] isEqual:@""])
            {
                [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(198/255.f) green:(255/255.f) blue:(216/255.f) alpha:1]];
            }
            else
            {
                if([[[boxes objectAtIndex:lb] text] isEqual:@"2"])
                {
                    [[boxes objectAtIndex:lb] setTextColor:[UIColor colorWithRed:(24/255.f) green:(24/255.f) blue:(24/255.f) alpha:1]];
                    [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(200/255.f) alpha:1]];
                    
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"4"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor colorWithRed:(24/255.f) green:(24/255.f) blue:(24/255.f) alpha:1]];
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(224/255.f) green:(255/255.f) blue:(163/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                        
                    } completion:nil];
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"8"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor colorWithRed:(24/255.f) green:(24/255.f) blue:(24/255.f) alpha:1]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(190/255.f) green:(190/255.f) blue:(255/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                        
                    } completion:nil];
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"16"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor colorWithRed:(24/255.f) green:(24/255.f) blue:(24/255.f) alpha:1]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(255/255.f) green:(201/255.f) blue:(64/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"32"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor colorWithRed:(224/255.f) green:(224/255.f) blue:(224/255.f) alpha:1]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(128/255.f) blue:(128/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"64"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor whiteColor]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(113/255.f) green:(60/255.f) blue:(255/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor colorWithRed:(255/255.f) green:(192/255.f) blue:(64/255.f) alpha:1]];
                        
                    } completion:nil];
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"128"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor blackColor]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(250/255.f) green:(155/255.f) blue:(230/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                
                if([[[boxes objectAtIndex:lb] text] isEqual:@"256"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor whiteColor]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(29/255.f) green:(92/255.f) blue:(157/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                if([[[boxes objectAtIndex:lb] text] isEqual:@"512"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor whiteColor]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(96/255.f) green:(75/255.f) blue:(25/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                
                if([[[boxes objectAtIndex:lb] text] isEqual:@"1024"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor whiteColor]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(195/255.f) green:(27/255.f) blue:(89/255.f) alpha:1]];
                        
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                        } completion:nil];
                }
                
                if([[[boxes objectAtIndex:lb] text] isEqual:@"2048"])
                {
                    [UIView transitionWithView:[boxes objectAtIndex:lb] duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [[boxes objectAtIndex:lb] setTextColor:[UIColor colorWithRed:(255/255.f) green:(8/255.f) blue:(159/255.f) alpha:1]];
                        
                        [[boxes objectAtIndex:lb] setBackgroundColor:[UIColor colorWithRed:(253/255.f) green:(238/255.f) blue:(42/255.f) alpha:1]];
                        
                        [[boxes objectAtIndex:lb] setShadowColor:[UIColor blueColor]];
                    } completion:nil];
                }
                
                
            }
        }
        
    }
    else
    {
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.view.backgroundColor = [UIColor clearColor];
            
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurEffectView.frame = self.view.bounds;
            blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.view addSubview:blurEffectView];
            
            
            
            ///additonal
            // Vibrancy effect
            UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
            UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
            [vibrancyEffectView setFrame:self.view.bounds];
            
            // Label for vibrant text
            UILabel *vibrantLabel = [[UILabel alloc] init];
            UIButton *vibrantButton = [[UIButton alloc] init];
            
            [vibrantLabel setText:@"You Lose!!"];
            [vibrantLabel setFont:[UIFont systemFontOfSize:26.0f]];
            [vibrantLabel sizeToFit];
            [vibrantLabel setCenter: self.view.center];
            
            [vibrantButton setTitle:@"Re-play" forState:UIControlStateSelected];
            [vibrantButton sizeToFit];
            // Add label to the vibrancy view
            [[vibrancyEffectView contentView] addSubview:vibrantLabel];
            [[vibrancyEffectView contentView] addSubview:vibrantButton];

            
            // Add the vibrancy view to the blur view
            [[blurEffectView contentView] addSubview:vibrancyEffectView];
        }
        else {
            self.view.backgroundColor = [UIColor blackColor];
        }
    }
    
}


@end
