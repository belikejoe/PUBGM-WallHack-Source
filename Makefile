export THEOS=/var/mobile/theos


ARCHS = arm64 

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ESPY




ESPY_FRAMEWORKS =  UIKit Foundation Security QuartzCore CoreGraphics CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController

ESPY_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
ESPY_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

ESPY_FILES = ImGuiDrawView.mm $(wildcard Esp/*.mm)   $(wildcard Esp/*.m) $(wildcard KittyMemory/*.cpp) $(wildcard KittyMemory/*.mm) $(wildcard img/*.m) 



#LQMNemOS_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
   install.exec "killall -9 kgvn || :"


