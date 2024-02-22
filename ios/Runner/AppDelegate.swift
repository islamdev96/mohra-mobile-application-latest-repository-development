import UIKit
import Flutter
import GoogleMaps
import Firebase
import flutter_background_service_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     GMSServices.provideAPIKey("AIzaSyDySfX1lMgwJqgptq44BrdwEAuUOsGj_jQ")
      FirebaseApp.configure()
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "close_app"
    GeneratedPluginRegistrant.register(with: self)

if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
// if #available(iOS 10.0, *) {
//   // For iOS 10 display notification (sent via APNS)
//   UNUserNotificationCenter.current().delegate = self
//
//   let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//   UNUserNotificationCenter.current().requestAuthorization(
//     options: authOptions,
//     completionHandler: { _, _ in }
//   )
// } else {
//   let settings: UIUserNotificationSettings =
//     UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//   application.registerUserNotificationSettings(settings)
// }

    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}