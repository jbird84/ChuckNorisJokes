//
//  ContainerViewController.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/17/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    lazy var favoritesVC = FavoritesViewController()
    var navVC: UINavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild()
        view.backgroundColor = .systemBackground
    }
    
    
    private func addChild() {
        //add menu
        menuVC.delegate = self
        add(menuVC)
        //add home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        add(navVC)
        self.navVC = navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        //Animate the menu
        switch menuState {
        case .closed:
            //open it
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 150
            } completion: { [weak self] done in
                guard let this = self else { return }
                if done {
                    this.menuState = .opened
                }
            }
            
        case .opened:
            //close it
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                guard let this = self else { return }
                if done {
                    this.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .home:
            resetToHomeVC()
        case .favorites:
            addFavorites()
        }
    }
    
    func addFavorites() {
        let favVC = favoritesVC
        homeVC.view.addSubview(favVC.view)
        favVC.view.frame = view.frame
        favVC.didMove(toParent: homeVC)
        homeVC.title = favVC.title
    }
    
    func resetToHomeVC() {
        favoritesVC.view.removeFromSuperview()
        favoritesVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
}
