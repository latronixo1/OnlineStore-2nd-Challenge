//
//  OnboardingViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Barnabas Bala on 04.03.2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    private let slides: [(image: String, title: String, description: String)] = [
        ("onbording1", "Welcome!", "Discover a fast and easy way to shop online."),
        ("onbording2", "Smart Search & Favorites", "Find products instantly and save favorites for later."),
        ("onbording3", "Easy Checkout", "Add to cart, choose payment, and order in seconds."),
        ("onbording4", "Manage Your Store", "Become a manager, add products, and control your catalog!")
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 326, height: 614) // Устанавливаем фиксированный размер ячейки
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.clipsToBounds = false // Важно! Отключаем обрезку содержимого
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemBlue.withAlphaComponent(0.2)
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        // Настраиваем размер точек
        pc.preferredIndicatorImage = UIImage.circle(diameter: 13)
        pc.preferredCurrentPageIndicatorImage = UIImage.circle(diameter: 13)
        
        return pc
    }()
    
    private let backgroundImageViewUp: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bubble 1"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let backgroundImageViewDown: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bubble 2"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundImageViewUp)
        view.addSubview(backgroundImageViewDown)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = slides.count
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) // Увеличиваем размер точек
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Фоновые изображения остаются без изменений
            backgroundImageViewUp.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageViewUp.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageViewUp.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageViewUp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            backgroundImageViewDown.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageViewDown.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageViewDown.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageViewDown.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            // Обновленные констрейнты для CollectionView
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 614), // Устанавливаем фиксированную высоту
            
            // PageControl
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func startButtonTapped() {
        let homeVC = TabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "OnboardingCell",
                for: indexPath
            ) as! OnboardingCell
            
            let slide = slides[indexPath.item]
            let isLastCell = indexPath.item == slides.count - 1
            cell.configure(with: slide.image, title: slide.title, description: slide.description, isLastCell: isLastCell)
            
            // Добавляем обработчик нажатия на кнопку
            if isLastCell {
                cell.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
            }
            
            return cell
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = Int(page)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 75 // Добавляем отступ между карточками
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           let screenWidth = UIScreen.main.bounds.width
           let cellWidth: CGFloat = 326
           let inset = (screenWidth - cellWidth) / 2
           return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
       }
}

extension UIImage {
    static func circle(diameter: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
}

