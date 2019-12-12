//
//  SceneDelegate.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) { }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) { }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) { }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) { }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
