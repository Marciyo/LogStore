//
//  File.swift
//  
//
//  Created by Marcel Mierzejewski on 15/10/2020.
//

import UIKit
import CoreMotion

public class LogTrigger {
    let window: UIWindow?
    let motionManager = CMMotionManager()
    
    public init(in window: UIWindow?) {
        self.window = window
        
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let data = data else { fatalError() }
            if data.acceleration.x < -5 {
                printLog("X acceleration: \(data.acceleration.x)")
                self?.presentLog()
            }
        }
    }
    
    func presentLog() {
        let visible = ​visibleViewController​(from: window?.rootViewController)
        let logViewController = LogViewController()
        visible?.present(logViewController, animated: true)
    }
    
    private func ​visibleViewController​(from viewController: UIViewController?) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return ​visibleViewController​(from: navigationController.topViewController)
        }
        
        if let tabBarController = viewController as? UITabBarController {
            return ​visibleViewController​(from: tabBarController.selectedViewController)
        }
        
        if let presentedViewController = viewController?.presentedViewController {
            return ​visibleViewController​(from: presentedViewController)
        }

        return viewController
    }
}
