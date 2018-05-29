#import "RCTBridgeModule.h"
#import "RNInstagramStoryShare.h"
// import RCTConvert
#if __has_include(<React/RCTConvert.h>)
#import <React/RCTConvert.h>
#elif __has_include("RCTConvert.h")
#import "RCTConvert.h"
#else
#import "React/RCTConvert.h"   // Required when used as a Pod in a Swift project
#endif

@implementation RNInstagramStoryShare
- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(share:(NSDictionary *)options
                  failureCallback:(RCTResponseErrorBlock)failureCallback
                  successCallback:(RCTResponseSenderBlock)successCallback) {
    NSString *deeplinkingUrl = [RCTConvert NSString:options[@"deeplinkingUrl"]];
    NSURL *backgroundImageUrl = [RCTConvert NSURL:options[@"backgroundImage"]];
    
    if(deeplinkingUrl && backgroundImageUrl){
        if ([backgroundImageUrl.scheme.lowercaseString isEqualToString:@"data"]) {
            NSString *errorMessage = @"Data conversion failed";
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
            NSError *error = [NSError errorWithDomain:@"com.rninstagramstoryshare" code:1 userInfo:userInfo];

            /* convert base64 string with scheme to base64 string only */
            NSData *data = [NSData dataWithContentsOfURL:backgroundImageUrl
                                                 options:(NSDataReadingOptions)0
                                                   error:&error];
            
            if (!data) {
                failureCallback(error);
                return;
            }

            /* deeplink to instagram */
            [self backgroundImage:UIImagePNGRepresentation([UIImage imageWithData:data])
                  attributionURL: deeplinkingUrl
                  failureCallback:failureCallback
                  successCallback:successCallback];

        } else {
            /* handle non base64 images */
            NSString *errorMessage = @"No base64 image";
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
            NSError *error = [NSError errorWithDomain:@"com.rninstagramstoryshare" code:1 userInfo:userInfo];

            failureCallback(error);
        }
    } else {
        /* handle non existing assets */
        NSString *errorMessage = @"Invalid parameter";
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
        NSError *error = [NSError errorWithDomain:@"com.rninstagramstoryshare" code:1 userInfo:userInfo];
        
        failureCallback(error);
    }
}

- (void)backgroundImage:(NSData *)backgroundImage
                attributionURL:(NSString *)attributionURL
                failureCallback:(RCTResponseErrorBlock)failureCallback
                successCallback:(RCTResponseSenderBlock)successCallback
{
    
    // Verify app can open custom URL scheme, open if able
    NSURL *urlScheme = [NSURL URLWithString:@"instagram-stories://share"];
    if ([[UIApplication sharedApplication] canOpenURL:urlScheme]) {
        
        // Assign background image asset and attribution link URL to pasteboard
        NSArray *pasteboardItems = @[@{@"com.instagram.sharedSticker.backgroundImage" : backgroundImage,
                                       @"com.instagram.sharedSticker.contentURL" : attributionURL}];
        if (@available(iOS 10.0, *)) {
            NSDictionary *pasteboardOptions = @{UIPasteboardOptionExpirationDate : [[NSDate date] dateByAddingTimeInterval:60 * 5]};
            // This call is iOS 10+, can use 'setItems' depending on what versions you support
            [[UIPasteboard generalPasteboard] setItems:pasteboardItems options:pasteboardOptions];
        } else {
            [[UIPasteboard generalPasteboard] setItems:pasteboardItems];
        }
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:urlScheme options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:urlScheme];
        }
        
    } else {
        NSString *errorMessage = @"Not installed";
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
        NSError *error = [NSError errorWithDomain:@"com.rninstagramstoryshare" code:1 userInfo:userInfo];

        failureCallback(error);
    }
}

- (NSDictionary *)constantsToExport
{
    return @{ @"NOT_INSTALLED": @"Not installed",
              @"INTERNAL_ERROR": @"Data conversion failed",
              @"NO_BASE64_IMAGE": @"No base64 image",
              @"INVALID_PARAMETER": @"Invalid parameter"
              };
}

@end
