//
//  ViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Barnabas Bala on 04.03.2025.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
                
                if currentIndex == 0 {
                    return pages.last               // wrap to last
                } else {
                    return pages[currentIndex - 1]  // go previous
                }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

                if currentIndex < pages.count - 1 {
                    return pages[currentIndex + 1]  // go next
                } else {
                    return pages.first              // wrap to first
                }
            }
    
    

    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        view.largeContentImage = .welcome
//        view.largeContentImage? = UIImage(named: "welcome")!
               
               setup()
               style()
               layout()

    }

}
    

    extension ViewController{
        func setup(){
            dataSource = self
            delegate = self
            
            pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
            
    //        let page1 = ViewController1()
    //        let page2 = ViewController2()
    //        let page3 = ViewController3()
          
            
            let page1 = OnboardingViewController(imageName: "Welcome",
                                                 titleText: "Welcome!",
                                                 subtitleText: "Discover a fast and easy way to shop online.")
            
            let page2 = OnboardingViewController(imageName: "SmartSearch",
                                                 titleText: "Smart Search & Favorites",
                                                 subtitleText: "Find products instantly and save favorites for later."
                                                 )
            let page3 = OnboardingViewController(imageName: "EasyCheckout",
                                                 titleText: "Easy checkout",
                                                 subtitleText: "Add to cart, choose payment, and order in seconds.")
            let page4 = OnboardingViewController(imageName: "ManageStore",
                                                 titleText: "Manage Your Store",
                                                 subtitleText: "Become a manager, add products, and control your catalog!")
            pages.append(page1)
            pages.append(page2)
            pages.append(page3)
            pages.append(page4)
            
            setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        }
        func style() {
                pageControl.translatesAutoresizingMaskIntoConstraints = false
                pageControl.currentPageIndicatorTintColor = .systemBlue
                pageControl.pageIndicatorTintColor = .systemGray2
                pageControl.numberOfPages = pages.count
                pageControl.currentPage = initialPage
            }
            
            func layout() {
                view.addSubview(pageControl)
                
                NSLayoutConstraint.activate([
                    pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
                    pageControl.heightAnchor.constraint(equalToConstant: 100),
                    view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
                ])
            }
    }

    extension ViewController {
        
        // How we change page when pageControl tapped.
        // Note - Can only skip ahead one page at a time.
        @objc func pageControlTapped(_ sender: UIPageControl) {
            setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        }
    }
    extension ViewController {
        
        // How we keep our pageControl in sync with viewControllers
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
            guard let viewControllers = pageViewController.viewControllers else { return }
            guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
            
            pageControl.currentPage = currentIndex
        }
    }

    //class ViewController1: UIViewController {
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        view.backgroundColor = .systemRed
    //    }
    //}
    //
    //class ViewController2: UIViewController {
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        view.backgroundColor = .systemGreen
    //    }
    //}
    //
    //class ViewController3: UIViewController {
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        view.backgroundColor = .systemBlue
    //    }
    //}



