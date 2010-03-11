//
//  CellsViewController.h
//  Cells
//
//  Created by Seonghyeon Choe on 3/11/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
	kNameValueTag = 1,
	kColorValueTag	= 2
};

@interface CellsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *computers;
}
@property (nonatomic, retain) NSArray *computers;

@end

