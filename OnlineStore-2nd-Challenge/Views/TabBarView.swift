////
////  TabBarView.swift
////  OnlineStore-2nd-Challenge
////
////  Created by Валентин Картошкин on 03.03.2025.
////
//
//import UIKit
////import Snapkit
//
//class TabBarCollectionView: UICollectionView {
//    
//    var flowLayout = UICollectionViewFlowLayout()
//    
//    private lazy var iconImage: UIImage = {
//        let element = UIImage()
//        
//        //element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
//    
//      override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: .zero, collectionViewLayout: flowLayout) //frame изначально будет нулевой (позже его определим), flowLayout тоже пока пустой
//      }
//
//
//      required init?(coder: NSCoder) {
//        fatalError("init(coder:) не был реализован")
//      }
//     
//    
////      func setupView() {
////        delegate = self
////        dataSource = self
////      }
//    }
//
//
//    extension TabBarCollectionView: UICollectionViewDataSource {
//      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {  //numberOfItemsInSection количество ячеев в коллекции
//        4  //4 - количество ячеек в коллекции
//      }
//     
//      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TabBarCollectionViewCell else { //если нам удастся прокастить cell до TabBarCollectionViewCell, то круто. А если нет, то вернем голый UICollectionViewCell
//          return UICollectionViewCell()
//        }
//        return cell
//      }
//    }
//
//
//    extension TabBarCollectionView: UICollectionViewDelegate {
//     
//    }
//
//    
//    //встроенная переменная isSelected. При нажатии на ячейку она становится true
////    override var isSelected: Bool {
////        didSet {
////            if isSelected {     //если она выбрана
////                tintColor = .black
//////                layer.borderWidth = 3
//////                layer.borderColor = #colorLiteral(red: 0.4426239431, green: 0.1398270428, blue: 0.4386208057, alpha: 1)
////            } else {
////                tintColor = #colorLiteral(red: 0, green: 0.2980392157, blue: 1, alpha: 1)
////                layer.borderWidth = 0
////            }
////        }
////    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        
//        setViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder) не определен")
//    }
//    
//    func setViews() {
//        view.addSubview(mainStackView)
////        mainStackView.addArrangedSubview(<#T##view: UIView##UIView#>)
//    }
//    
//    func setupConstraints() {
//        
//    }
//}
