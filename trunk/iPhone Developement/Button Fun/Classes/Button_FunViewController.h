//
//  Button_FunViewController.h
//  Button Fun
//
//  Created by Seonghyeon Choe on 3/2/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button_FunViewController : UIViewController {
	IBOutlet UILabel *statusText;
}

@property (retain, nonatomic) UILabel *statusText;

- (IBAction)buttonPressed:(id)sender;

@end

