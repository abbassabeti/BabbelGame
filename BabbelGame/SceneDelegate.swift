//
//  SceneDelegate.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {return}
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        InitialGameRouter().presentInitialGame()
    }
    
    static var shared: SceneDelegate? {
        for scene in UIApplication.shared.connectedScenes {
            if let delegate = scene.delegate as? SceneDelegate {
                return delegate
            }
        }
        return nil
    }
    
    class func presentView(view: AnyView){
        guard let delegate = SceneDelegate.shared else {
            return
        }
        let hostingVC = UIHostingController(rootView: view)
        if let navC = delegate.window?.rootViewController as? UINavigationController{
            navC.pushViewController(hostingVC, animated: true)
        }
        let navC = UINavigationController(rootViewController: hostingVC)
        delegate.window?.rootViewController = navC
        delegate.window?.makeKeyAndVisible()
    }
}

