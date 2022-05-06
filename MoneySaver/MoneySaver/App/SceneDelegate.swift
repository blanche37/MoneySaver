//
//  SceneDelegate.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = main.instantiateViewController(withIdentifier: "root") as? UINavigationController,
              let list = vc.viewControllers.first as? ListViewController else {
                return
        }
        
        let repository: Repository = SQLiteRepository()
        let service: Service = MoneySaverService(repository: repository)
        let viewModel: ViewModel = MoneySaverViewModel(service: service)
       
        list.viewModel = viewModel
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataStack.shared.saveContext()
    }
}

