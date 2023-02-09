//
//  TabViewController.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBar()
        setupTabBarAppearence()
    }
    
    private func createTabBar() {
        viewControllers = [
            createVC(viewController: MainViewController(), title: "Главная", image: "news"),
            createVC(viewController: InfoViewController(), title: "Инфо", image: "info"),
            createVC(viewController: GalleryViewController(), title: "Галерея", image: "galery"),
            createVC(viewController: AboutUsViewController(), title: "О нас", image: "aboutUs")
        ]
    }
    
    private func createVC(viewController: UIViewController, title: String, image: String) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: image)
        viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }
    
    private func setupTabBarAppearence() {
//        tabBar.backgroundColor = .black
    }
}
