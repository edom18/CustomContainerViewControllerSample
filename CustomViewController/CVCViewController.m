
#import "CVCViewController.h"

#import "CVCOtherViewController.h"

@interface CVCViewController ()

@end

@implementation CVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];

    // 2秒後にアニメーションなしでViewControllerを追加
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        __block CVCOtherViewController *vc = [[CVCOtherViewController alloc] init];
        vc.view.backgroundColor = [UIColor redColor];
        [self displayContentController:vc];
        
        // さらに2秒後に、今度はアニメーション付きで追加
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CVCOtherViewController *ovc = [[CVCOtherViewController alloc] init];
            ovc.view.backgroundColor = [UIColor greenColor];
            
            [self cycleFromViewController:vc toViewController:ovc];
        });
    });
}


// 指定したViewControllerを追加
- (void)displayContentController:(UIViewController *)content
{
    // 自身のビューコントローラ階層に追加
    // 自動的に子ViewControllerの`willMoveToParentViewController:`メソッドが呼ばれる
    [self addChildViewController:content];
    
    // 子ViewControllerの表示領域を設定
    content.view.frame = self.view.bounds;
    
    // 子ViewControllerのviewを、自身のview階層に追加
    [self.view addSubview:content.view];
    
    // 子ViewControllerに追加されたことを通知
    [content didMoveToParentViewController:self];
}


// 指定したViewControllerを削除
- (void)hideContentController:(UIViewController *)content
{
    // これから取り除かれようとしていることを通知する
    [content willMoveToParentViewController:nil];
    
    // 子ViewControllerの`view`を取り除く
    [content.view removeFromSuperview];
    
    // 子ViewControllerを取り除く
    // 自動的に`didMoveToParentViewController:`が呼ばれる
    [content removeFromParentViewController];
}


// アニメーションでふたつのViewControllerを入れ替え
- (void)cycleFromViewController:(UIViewController *)oldC
               toViewController:(UIViewController *)newC
{
    [oldC willMoveToParentViewController:nil];
    CGFloat width  = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGRect startFrame = CGRectMake(0, height, width, height);
    [self addChildViewController:newC];
    
    newC.view.frame = startFrame;
    CGRect endFrame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self transitionFromViewController:oldC
                      toViewController:newC
                              duration:0.25
                               options:0
                            animations:^{
                                newC.view.frame = oldC.view.frame;
                                oldC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                NSLog(@"OK");
                                [oldC removeFromParentViewController];
                                [newC didMoveToParentViewController:self];
                            }];
}

@end
