ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:5.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = LPTheos
LPTheos_CFLAGS = -fobjc-arc
LPTheos_FILES = LPTheos.xm LPView.m LPViewController.m
LPTheos_FRAMEWORKS = Foundation UIKit
LPTheos_LDFLAGS = -llockpages

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
