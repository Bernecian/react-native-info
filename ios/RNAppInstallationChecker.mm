#import "RNAppInstallationChecker.h"
#import <React/RCTLog.h>
#import <UIKit/UIKit.h>

@implementation RNAppInstallationChecker

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(RNAppInstallationChecker:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSString *receiptPath = receiptURL.path;

    if ([[NSFileManager defaultManager] fileExistsAtPath:receiptPath]) {
        // Check if the app is installed from the App Store
        NSDictionary *receiptDictionary = [NSDictionary dictionaryWithContentsOfFile:receiptPath];
        NSString *receiptType = receiptDictionary[@"receipt_type"];

        if ([receiptType isEqualToString:@"Production"]) {
            resolve(@YES); // App is from App Store
        } else {
            resolve(@NO); // App is from TestFlight
        }
    } else {
        // If the receipt doesn't exist, it's not from the App Store or TestFlight
        resolve(@NO);
    }
}

@end
