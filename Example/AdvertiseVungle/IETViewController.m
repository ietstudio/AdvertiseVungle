//
//  IETViewController.m
//  AdvertiseVungle
//
//  Created by gaoyang on 06/02/2016.
//  Copyright (c) 2016 gaoyang. All rights reserved.
//

#import "IETViewController.h"
#import "VGAdvertiseHelper.h"

@interface IETViewController ()

@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation IETViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.msgLabel.text = [[VGAdvertiseHelper getInstance] getName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSpot:(id)sender {
    BOOL result = [[VGAdvertiseHelper getInstance] showSpotAd:^(BOOL result) {
        NSLog(@"SpotAd Click: %@", result?@"YES":@"NO");
    }];
    NSLog(@"SpotAd Show: %@", result?@"YES":@"NO");
}

- (IBAction)isVideoReady:(id)sender {
    BOOL result = [[VGAdvertiseHelper getInstance] isVedioAdReady];
    NSLog(@"VedioAd Ready: %@", result?@"YES":@"NO");
    self.msgLabel.text = [NSString stringWithFormat:@"VedioAd Ready: %@", result?@"YES":@"NO"];

}

- (IBAction)showVideo:(id)sender {
    BOOL result = [[VGAdvertiseHelper getInstance] showVedioAd:^(BOOL result) {
        NSString* msg = [NSString stringWithFormat:@"VedioAd Valid: %@", result?@"YES":@"NO"];
        NSLog(@"%@", msg);
    } :^(BOOL result) {
        NSString* msg = [NSString stringWithFormat:@"VedioAd Click: %@", result?@"YES":@"NO"];
        NSLog(@"%@", msg);
    }];
    NSLog(@"VedioAd Show: %@", result?@"YES":@"NO");
}

@end
