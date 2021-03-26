import UIKit
import Flutter
import Firebase
import OneSignal

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // if #available(iOS 10.0, *) {
    //   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    // }
     GeneratedPluginRegistrant.register(with: self)
    // Remove this method to stop OneSignal Debugging
     OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

     // OneSignal initialization
     OneSignal.initWithLaunchOptions(launchOptions)
     OneSignal.setAppId("YOUR_ONESIGNAL_APP_ID")

     // promptForPushNotifications will show the native iOS notification permission prompt.
     // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
     OneSignal.promptForPushNotifications(userResponse: { accepted in
       print("User accepted notifications: \(accepted)")
     })

     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    override init() { FirebaseApp.configure() }
    
    
}
 
