//
//  ViewController.m
//  Example
//
//  Created by 刘鹏i on 2019/11/7.
//  Copyright © 2019 Liupeng. All rights reserved.
//

#import "ViewController.h"
#import "SoundWaveView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet SoundWaveView *soundView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickedStart:(id)sender {
    [_soundView startAnimation];
}

- (IBAction)clickedPause:(id)sender {
    [_soundView pauseAnimation];
}


@end
