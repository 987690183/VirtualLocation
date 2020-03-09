//
//  AppDelegate.h
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/9.
//  Copyright © 2019 luolei. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "LLDevicePool.h"
@interface AppDelegate : NSObject <NSApplicationDelegate,LLDeviceConnectionDelegate>
{
    WKWebView *_webView;
    LLDevicePool *_devicePool;
    __weak IBOutlet NSPopUpButton *_popupButton;
    __weak IBOutlet NSTextField *_deviceNameTextField;
    __weak IBOutlet NSTextField *_productNameTextField;
    __weak IBOutlet NSTextField *_productTypeTextField;
    __weak IBOutlet NSTextField *_iOSVersionTextField;
    
    __weak IBOutlet NSButton *_locationButton;
    __weak IBOutlet NSButton *_restoreLButton;
    __weak IBOutlet NSButton *_restartButton;
    __weak IBOutlet NSButton *_installDevButton;
}
@property (weak) IBOutlet NSView *contentView;
@property (weak) IBOutlet NSTextField *lngTextField;
@property (weak) IBOutlet NSTextField *latTextField;
- (IBAction)location:(id)sender;
- (IBAction)restoreLocation:(id)sender;
- (IBAction)restartDevice:(id)sender;
- (IBAction)installDeveloper:(id)sender;

@end

