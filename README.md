# LockPages Example
## 
#### What's LockPages? ![Confused icon](http://pigigaldi.com/lockpages/images/confused.png)
## 
>  
> *LockPages* is a support package for other tweaks to add pages to the lockscreen.

> *LockPages* is a package created by *[David Ashman]*.

> *[Forecast]* or *[LockInfo]* is an example of its potentiality.

## 

## Getting Started
##### Required Files

| **`liblockpages.dylib`** | **`LPPageController.h`**               |
| :----------------------- | :------------------------------------- |
|  `/opt/theos/lib/`       | `/opt/theos/include/liblockpages/`     |
|  **`NOTE:`**             | `liblockpages` folder must be created. |
|  *`Download:`*           | [liblockpagesEssential.zip]            |

> ###### Files in *`liblockpagesEssential.zip`* must be placed in their respective folders.

***
## Where to start?
#### LPView.h
***
First of all we need to create a *`UIView`* subclass and I named it *`LPView`*.

```
	// LPView.h
	
	@interface LPView : UIView {
		// subclass! :)
	}
	@end
```

Now, we have to add *`LPPage`* protocol before *`@interface`*.

```	
	// From David Ashman website: http://blog.dba-technologies.com/
	
	@class UIView;
	@protocol LPPage <NSObject>
	- (UIView *)view;
	- (NSInteger)priority;
	
	[...]
	
	@end
	
	@interface LPView : UIView {
		id <LPPage> _page;
	}
	@end
```

Alright, at this point let's add a method to *`LPView`* to let us setting his delegate later.

```
	[...]
	
	@interface LPView : UIView {
		id <LPPage> _page;
	}
	- (void)setDelegate:(id<LPPage>)_delegate;
	@end
```

## 
#### LPView.m
***
Ok, now we can create the implementation of *`LPView`*.

```
	// LPView.m
	
	#import "LPView.h"

	@implementation LPView
	// Init methods.
	- (id)initWithFrame:(CGRect)frame {
		self = [super initWithFrame:frame];
		return self;
	}
	// This method is called by LPViewController.
	- (void)setDelegate:(id<LPPage>)_delegate {
		self->_page = _delegate;
	}
	// From here on, you can do whatever you want! :D
	// Remember, LPView is a subclass of UIView!
	@end
```

## 
#### LPViewController.h
***
Well, now we need to create a *`UIViewController`* subclass (and I named it *`LPViewController`*) and create a *`LPView`* instance.
 
```
	// LPViewController.h

	#import "LPView.h"
	
	// Remember to set LPPage protocol here.
	@interface LPViewController : UIViewController <LPPage>
	@property (nonatomic, retain) LPView *_mainView;
	@end

```

## 
#### LPViewController.m
***
We can now go to set *`LPViewController`* implementation.

```
	// LPViewController.m

	#import "LPViewController.h"

	@implementation LPViewController
	- (id)init {
		self = [super init];
		if (self){
			__mainView = [[LPView alloc] initWithFrame:[UIScreen mainScreen].bounds];
			[__mainView setDelegate:self];
			[__mainView setBackgroundColor:[UIColor redColor]];
			[self setView:__mainView];
		}
		return self;
	}
	- (NSInteger)priority {
		return 10; // Pages are rendered in descending priority order.
	}

```

## 
#### TweakName.xm
***
After creating *`LPView`* and *`LPViewController`* we can now edit our
*`TweakName.xm`*.

```
	// TweakName.xm
	
	#import "LPViewController.h"

	%ctor {
		@autoreleasepool {
			LPViewController *_mainPage = [[LPViewController alloc] init];
			[[LPPageController sharedInstance] addPage:_mainPage];
	}
}

```

> I spent few hours decrypting *`liblockpages.dylib`* to figure out how pages are added to *`LPPageController`*.

> Eventually I came to the conclusion that *`addPage:`* needs a *`UIViewController`* class to NOT crash your SpringBoard! :D (It was 4AM, I was very tired! :P)

> Thanks David, why you didn't specified it in your "Documentation"? :P

## 
#### Makefile
***
BTW, now we just have to modify the *`Makefile`* in order to build our tweak properly.

```
	// Makefile
	
	// First we have to include LPView and LPViewController implementation file to compile them.
	TweakName_FILES = TweakName.xm LPView.m LPViewController.m
	
	// And then we just have to link liblockpages.dylib:
	TweakName_LDFLAGS = -llockpages
	
```

That's all! We're done! :D

> It wasn't so difficult, wasn't it? :P

*** 

## Thanks
> I would like to thanks *[David Ashman]* for creating *LockPages*.

> I would like to thanks *[Jay Freeman "Saurik"]* for creating *Cydia Substrate*.

> Also thanks to *[Vincent Bénony (aka bSr43)]* for creating *Hopper Disassembler*.
> ## 

## Contact
> ***Pigi Galdi*** *(aka [DjKira])* | [pigigaldi.com](http://pigigaldi.com) | [info@pigigaldi.com](mail://info@pigigaldi.com) 	

<!--/////////////////////////////////////////////////////////////////////-->

[djkira]:http://twitter.com/DjKira_
[david ashman]:http://twitter.com/davidbashman
[forecast]:http://modmyi.com/info/forecast.d.php
[lockinfo]:http://www.lockinfo.net/cydia/modmyi/lockinfo7.d.php
[liblockpagesEssential.zip]:http://pigigaldi.com/lockpages/liblockpagesEssential.zip
[jay freeman "saurik"]:http://twitter.com/saurik
[Vincent Bénony (aka bSr43)]:http://www.hopperapp.com