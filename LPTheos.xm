//
//  LPTheos.xm
//  LPTheos
//
//  Created by Pigi Galdi on 14.10.2014.
//  Copyright (c) 2014 Pigi Galdi. All rights reserved.
//
// 	Imports.
#import "Imports.h"

%ctor {
	@autoreleasepool {
		// Create page.
		LPViewController *_mainPage = [[LPViewController alloc] init];
		// Adding page to lockscreen.
		// I spent a few hours decrypting "liblockpages.dylib" to figure out how page are added to LPPageController.
		// Eventually I came to the conclusion that "addPage:" needs a UIViewController class to NOT crash your SpringBoard! :D (It was 4AM, I was very tired! :P)
		// Thanks David, why you didn't specified it in your "Documentation"? :P
		[[LPPageController sharedInstance] addPage:_mainPage];
	}
}
