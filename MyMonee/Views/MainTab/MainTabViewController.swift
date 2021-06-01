//
//  MainTabViewController.swift
//  MyMonee
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .white
        
        let home = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let homeTab = UINavigationController(rootViewController: home)
        let homeImage = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        let homeImageSelected = UIImage(named: "Home_Selected")?.withRenderingMode(.alwaysTemplate)
        
        homeTab.setNavigationBarHidden(true, animated: false)
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImageSelected)
        homeTab.tabBarItem.tag = 0
        
        let impian = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        let impianTab = UINavigationController(rootViewController: impian)
        let impianImage = UIImage(named: "Favorite")?.withRenderingMode(.alwaysOriginal)
        let impianImageSelected = UIImage(named: "Favorite_Selected")?.withRenderingMode(.alwaysTemplate)
        
        impianTab.setNavigationBarHidden(true, animated: false)
        impianTab.tabBarItem = UITabBarItem(title: "Impian", image: impianImage, selectedImage: impianImageSelected)
        impianTab.tabBarItem.tag = 1
        
        
        let profile = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileTab = UINavigationController(rootViewController: profile)
        let profileImage = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        let profileImageSelected = UIImage(named: "Profile_Selected")?.withRenderingMode(.alwaysTemplate)
        
        profileTab.setNavigationBarHidden(true, animated: false)
        profileTab.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileImageSelected)
        profileTab.tabBarItem.tag = 1
        
        
        self.viewControllers = [homeTab, impianTab, profileTab]
    }
}
