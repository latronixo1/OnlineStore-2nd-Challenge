//
//  TabBar.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 05.03.2025.
//

import UIKit

//класс исключительно для индикатора (линии) под выбранной кнопкой (в UITabBarController)
class TabBar: UITabBar {
    private var indicatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupIndicator()
    }
    
    func setupIndicator() {
        //создаем индикатор (линию)
        indicatorView = UIView()
        indicatorView.backgroundColor = .black //цвет линии
        self.addSubview(indicatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //обновляем позицию индикатора
        updateIndicatorPosition()
    }
    
    private func updateIndicatorPosition() {
        guard let items = self.items, items.count > 0 else { return }
        
        //ширина индикатора равна ширине TabBar, деленной на количество элементов, от этого уменьшаем на 60:
        let itemWidth = self.frame.width / CGFloat(items.count)
        let indicatorWidth = itemWidth * 0.17    //ширина линии (% от ширины кнопки)
        let indicatorHeight: CGFloat = 2

        //позиция индикатора
        let xPosition = itemWidth * CGFloat(selectedItem?.tag ?? 0) + (itemWidth - indicatorWidth) / 2
        let yPosition = self.frame.height * 0.45
        
        //обновляем frame индикатора
        indicatorView.frame = CGRect(x: xPosition, y: yPosition, width: indicatorWidth, height: indicatorHeight)
        
        // Анимация изменения позиции индикатора
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.frame = CGRect(x: xPosition, y: yPosition, width: indicatorWidth, height: indicatorHeight)
        }
    }
    
    
}
