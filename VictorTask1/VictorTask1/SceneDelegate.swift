//
//  SceneDelegate.swift
//  VictorTask1
//
//  Created by Mironchik on 26.10.24.
//

import UIKit
import RealmSwift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var tabBarController: UITabBarController {
        return window!.rootViewController as! UITabBarController
    }
    
    var taskListViewController: SurveyListViewController {
        let navigationController = tabBarController.viewControllers!.first as! UINavigationController
        return navigationController.visibleViewController as! SurveyListViewController
    }
    
    var resultViewController: ResultViewController? {
        let navigationController = tabBarController.viewControllers![1] as! UINavigationController

        // Find the `ResultViewController` (if any) that's a view controller in the navigation controller.
        return navigationController.viewControllers.first(where: { (someVC) -> Bool in
            someVC is ResultViewController
        }) as? ResultViewController
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        taskListViewController.taskResultFinishedCompletionHandler = { [unowned self] taskResult in
            /*
                If we're displaying a new result, make sure the result view controller's
                navigation controller is at the root.
            */
            if let navigationController = self.resultViewController?.navigationController {
                navigationController.popToRootViewController(animated: false)
            }

            // Set the result so we can display it.
            self.resultViewController?.result = taskResult
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

