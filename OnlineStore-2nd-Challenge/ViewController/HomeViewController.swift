//
//  HomeViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let mainView: HomeView = .init()
    private var items:[Product] = []
    private var category: [String] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        makeProduct()
        mainView.popularCollectionView.register(HeaderHomeCollection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderHomeCollection.reuseIdentifier)
        
    }
    func makeProduct() {
        NetworkService.shared.fetchProducts { result in
            switch result {
            case .success(let products):
                self.items = products
                var newcategore:[String] = []
                for product in products {
                    newcategore.append(product.category)
                }
                self.category = Array(Set(newcategore)).sorted()
            
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    
}
//MARK: UITableView
extension HomeViewController: UITableViewDelegate {
    
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case mainView.categoryTableView :
            return category.count
        case mainView.justForYouTableView : return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
//MARK: UICollection
extension HomeViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: 30)
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           if kind == UICollectionView.elementKindSectionHeader {
               guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderHomeCollection.reuseIdentifier, for: indexPath) as? HeaderHomeCollection else {
                   fatalError("Cannot dequeue reusable supplementary view")
               }
               return header
           }
           return UICollectionReusableView()
       }
        
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
//MARK: ScrollView
extension HomeViewController: UIScrollViewDelegate {
    
}
