//
//  AppDelegate.m
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/9.
//  Copyright © 2019 luolei. All rights reserved.
//

#import "AppDelegate.h"
#import "LLSimulatelocation.h"
#import "DiagnosticsRelay.h"
#import "Deviceimagemounter.h"
#import <objc/runtime.h>
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (void)awakeFromNib
{
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"jsCallOc"];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:NSMakeRect(250, 0, NSWidth(_contentView.frame) - 250, NSHeight(_contentView.frame))configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *urlPath = [NSString stringWithFormat:@"%@/Contents/Resources/BaiduMap/mapView.html",path];
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [_contentView addSubview:_webView];
    [self setActionButtonsEnable:NO];
    _devicePool = [[LLDevicePool alloc] init];
    _devicePool.delegate = self;
    [_devicePool startLisen];
    [_popupButton.menu removeAllItems];
    [_popupButton setTarget:self];
    [_popupButton setAction:@selector(deviceChanged:)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popUpwillPopup:) name:NSPopUpButtonWillPopUpNotification object:nil];
    NSMenuItem *item = [[NSMenuItem alloc] init];
    [item setTitle:@"Please connect your iOS device"];
    item.tag = 100;
    [_popupButton.menu  addItem:item];
}

- (void)deviceChanged:(id)sender
{
    NSPopUpButton *button = (NSPopUpButton *)sender;
    NSMenuItem *selectedItem = button.selectedItem;
    NSMenuItem *titleitem = [self->_popupButton.menu itemWithTag:100];
    [titleitem setTitle:selectedItem.title];
    [self initDeviceInfo:selectedItem.representedObject];
}

- (void)popUpwillPopup:(NSNotification *)notification
{
    NSMenuItem *selecteditem = [_popupButton selectedItem];
    for (NSMenuItem *item in [[_popupButton menu] itemArray]) {
        if (item == selecteditem) {
            [item setState:NSOnState];
        }else if(item.tag != 100){
            [item setState:NSOffState];
        }
    }
}

#pragma mark - LLDeviceConnectionDelegate
- (void)notifyDeviceConnection:(NSString *)udid{
    dispatch_sync(dispatch_get_main_queue(), ^{
        LLDevice *device = [self->_devicePool getDevice:udid];
        if ([self->_devicePool deviceCount] > 0){
            [self setActionButtonsEnable:YES];
            NSMenuItem *item = [[NSMenuItem alloc] init];
            [item setTitle:[NSString stringWithFormat:@"%@(%@)",device.deviceName,device.serialNumber]];
            item.representedObject = device;
            [self->_popupButton.menu  addItem:item];
            if ([self->_devicePool deviceCount] == 1) {
                [self->_popupButton selectItem:item];
                NSMenuItem *titleitem = [self->_popupButton.menu itemWithTag:100];
                [titleitem setTitle:item.title];
                [self initDeviceInfo:device];
            }
        }
        
    });
}
- (void)notifyDeviceDisConnection:(NSString *)udid{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMenuItem *disitem = nil;
        NSMenuItem *selectedItem = [self->_popupButton selectedItem];
        for (NSMenuItem *item in self->_popupButton.menu.itemArray) {
            LLDevice *device = (LLDevice *)item.representedObject;
            if ([device.udid isEqualToString:udid]) {
                disitem = item;
            }
        }
        if (selectedItem == disitem) {
            for (NSMenuItem *item in self->_popupButton.menu.itemArray) {
                LLDevice *device = (LLDevice *)item.representedObject;
                if ((![device.udid isEqualToString:udid]&&item.tag != 100)) {
                    [self->_popupButton selectItem:item];
                    [self->_popupButton setTitle:item.title];
                    [self initDeviceInfo:item.representedObject];
                    break;
                }
            }
        }
        if (disitem != nil) {
            [self->_popupButton.menu removeItem:disitem];
        }
        if ([self->_devicePool deviceCount] == 0) {
            NSMenuItem *titleitem = [self->_popupButton.menu itemWithTag:100];
            [titleitem setTitle:@"Please connect your iOS device"];
            [self initDeviceInfo:[LLDevice new]];
            [self setActionButtonsEnable:NO];
        }
     });
}

- (void)setActionButtonsEnable:(BOOL)enable
{
    [_locationButton setEnabled:enable];
    [_restoreLButton setEnabled:enable];
    [_restartButton setEnabled:enable];
    [_installDevButton setEnabled:enable];
}

- (void)initDeviceInfo:(LLDevice *)device
{
    [_deviceNameTextField setStringValue:device.deviceName?:@""];
    [_productNameTextField setStringValue:device.productName?:@""];
    [_productTypeTextField setStringValue:device.productType?:@""];
    [_iOSVersionTextField setStringValue:device.iOSVersion?:@""];
}


#pragma mark - webview NavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"finish load");
    [webView evaluateJavaScript:@"add_control()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"response: %@ error: %@", response, error);
    }];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSDictionary *dic = (NSDictionary *)message.body;
    [_lngTextField setStringValue:[dic objectForKey:@"lng"]];
    [_latTextField setStringValue:[dic objectForKey:@"lat"]];
}

- (void)dealloc
{
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsCallOc"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Actions
- (IBAction)location:(id)sender {

    NSMenuItem *selectedItem = _popupButton.selectedItem;
    LLDevice *device = (LLDevice *)selectedItem.representedObject;
    NSString *laStr = self.latTextField.stringValue;
    NSString *lngStr = self.lngTextField.stringValue;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([LLSimulatelocation simulateLocation:laStr lng:lngStr udid:device.udid]) {
            NSLog(@"location success");
        }else{
            NSLog(@"location faild");

        }
    });
}

- (IBAction)restoreLocation:(id)sender {
    NSMenuItem *selectedItem = _popupButton.selectedItem;
    LLDevice *device = (LLDevice *)selectedItem.representedObject;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([LLSimulatelocation restoreLocation:device.udid]) {
            NSLog(@"restoreLocation success");
        }else{
            NSLog(@"restoreLocation faild");
        }
    });
}

- (IBAction)restartDevice:(id)sender {
    NSMenuItem *selectedItem = _popupButton.selectedItem;
    LLDevice *device = (LLDevice *)selectedItem.representedObject;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([DiagnosticsRelay restartDevice:device.udid]) {
            NSLog(@"reboot success");
        }else{
            NSLog(@"reboot faild");
        }
    });
}

- (IBAction)installDeveloper:(id)sender {
    NSMenuItem *selectedItem = _popupButton.selectedItem;
    LLDevice *device = (LLDevice *)selectedItem.representedObject;
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setAllowedFileTypes:@[@"dmg"]];
    [openPanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result== NSFileHandlingPanelOKButton) {
            NSString *dmgPath = [[openPanel URL] path];
            NSString *signPath = [dmgPath stringByAppendingString:@".signature"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:signPath]) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    if ( [Deviceimagemounter mountImage:dmgPath signPath:signPath udid:device.udid]) {
                        NSLog(@"reboot success");
                    }else{
                        NSLog(@"reboot faild");
                    }
                });
            }else{
                NSLog(@"it can't find sinpath");
            }
            
        }
    }];
   
    
    
}
@end
