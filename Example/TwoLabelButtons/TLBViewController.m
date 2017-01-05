//
//  TLBViewController.m
//  TwoLabelButtons
//
//  Created by Andrei Yangabishev on 01/05/2017.
//  Copyright (c) 2017 Andrei Yangabishev. All rights reserved.
//

#import "TLBViewController.h"
#import "TwoLabelButtons/TwoLabelButtons.h"

@interface TLBViewController () <TLBViewDataSource,TLBViewDelegate>
@property (nonatomic) IBOutlet TLBView *twoLabelButtons;
@end

@implementation TLBViewController {
  int _counter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  self.twoLabelButtons.delegate = self;
  self.twoLabelButtons.datasource = self;
  [self.twoLabelButtons reload];
  
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)twoLabelButtons:(TLBView *)twoLabelButtons firstTitle:(NSUInteger)index {
  return [NSString stringWithFormat:@"first title %u %u", _counter++, index];
}

- (NSString *)twoLabelButtons:(TLBView *)twoLabelButtons secondTitle:(NSUInteger)index {
  return [NSString stringWithFormat:@"second title %u %u", _counter++, index];
}

- (void)twoLabelButtons:(TLBView *)twoLabelButtons didSelected:(NSUInteger)index {
  NSLog(@"selected %u", index);
}

- (IBAction)click:(id)sender {
  self.twoLabelButtons.enabled = !self.twoLabelButtons.enabled;
}

- (IBAction)reload:(id)sender {
  [self.twoLabelButtons reload];
}

@end
