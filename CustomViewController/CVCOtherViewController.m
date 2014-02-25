
#import "CVCOtherViewController.h"

@interface CVCOtherViewController ()

@end

@implementation CVCOtherViewController


/**
 * 以下のライフサイクルは動作確認用です。
 */

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"view did load.");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear.");
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"view will disappear.");
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"view did disappear.");
}

@end
