//
//  LockLyrics7.xm
//  LockLyrics7
//
//  Created by Pigi Galdi on 13.10.2014.
//  Copyright (c) 2014 Pigi Galdi. All rights reserved.
//
//	Imports.
#import "Imports.h"

@implementation LPViewController
- (id)init {
	self = [super init];
	if (self){
		// Init __mainView.
		__mainView = [[LPView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		// Calling methods declared in LPView.h to set LPViewController as delegate of LPPage protocol.
		[__mainView setDelegate:self];
		// Remeber: LPView is a subclass of UIView! ;)
		[__mainView setBackgroundColor:[UIColor redColor]];
		// Setting LPView as LPViewController's view.
		[self setView:__mainView];
	}
	return self;
}
// 	Delegate methods. 
// 	See LPView.h for more methods.
- (NSInteger)priority {
	return 10; // Pages are rendered in descending priority order, so use an high value to put your view as first or a lower to put your page as last page.
}
@end
