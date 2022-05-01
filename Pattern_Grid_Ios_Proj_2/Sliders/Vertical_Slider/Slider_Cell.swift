//
//  Vertical_Slider_Cell.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 25/04/2022.
//

import Foundation
import SwiftUI
import UIKit

class Slider_Cell: UICollectionViewCell {
    
    private static let reuseId = "SliderCell"
    
    public var counter = 0

    static func registerWithCollectionView(collectionView: UICollectionView) {
        collectionView.register(Slider_Cell.self, forCellWithReuseIdentifier: reuseId)
    }

    static func getReusedCellFrom(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> Slider_Cell{
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! Slider_Cell
    }

    var Cell_Info_View: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(self.Cell_Info_View)

        Cell_Info_View.text = "\(self.counter)"
        Cell_Info_View.textAlignment = .center
        Cell_Info_View.font = UIFont(name: "Helvetica Bold", size: 16.0)
        Cell_Info_View.translatesAutoresizingMaskIntoConstraints = false

        Cell_Info_View.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        Cell_Info_View.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        Cell_Info_View.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        Cell_Info_View.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    func update() {
        Cell_Info_View.text = "\(self.counter)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented error from SliderCell")
    }
}
