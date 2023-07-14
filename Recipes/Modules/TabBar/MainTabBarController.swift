//
//  MainTabBarController.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit
//import SwiftUI

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.tintColor = .appOrange
        self.tabBar.barTintColor = .appBackground
        self.tabBar.backgroundColor = .appBackground
        self.tabBar.unselectedItemTintColor = .lightGray
    }
    
}

//struct Main_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let mainTabBarController: MainTabBarController = .init()
//            let mainTabBarRouter = MainTabBarRouter(tabBarController: mainTabBarController)
//            mainTabBarRouter.start()
//            return mainTabBarController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
