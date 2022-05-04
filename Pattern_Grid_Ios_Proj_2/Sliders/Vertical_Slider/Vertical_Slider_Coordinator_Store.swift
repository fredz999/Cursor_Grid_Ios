//
//  Vertical_Slider_Coordinator_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 04/05/2022.
//

import Foundation
import SwiftUI
import UIKit

class Vertical_Slider_Coordinator_Store: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ObservableObject {
    
    //private var parent: Vertical_Slider_View
    
    let lcldimensions = ComponentDimensions.StaticComponentDimensions
    
//    init(_ gridView: Vertical_Slider_View) {
//        self.parent = gridView
//    }
    
    var vertical_Slider_Responders : [P_VSlider_Responder] = []
    
    override init(){
//                let vSliderStart : Int = lcldimensions.returnGridVerticalStart()
//                let vSliderEnd : Int = lcldimensions.returnGridVerticalEnd()
//
//                for i in vSliderStart..<vSliderEnd {
//                    v_Slider_Data.append(i)
//                }
        
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //self.parent.v_Slider_Data.count
        lcldimensions.returnGridVerticalEnd()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vertical_Slider_Cell = Slider_Cell.getReusedCellFrom(collectionView: collectionView, cellForItemAt: indexPath)
        vertical_Slider_Cell.backgroundColor = .lightGray
        vertical_Slider_Cell.labelText = indexPath.item //self.parent.v_Slider_Data[indexPath.item]
        vertical_Slider_Cell.update()
        return vertical_Slider_Cell
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if vertical_Slider_Responders.count > 0 {
            for res in vertical_Slider_Responders {
                res.react_To_Swiper_Y(y_OffsetParam: scrollView.contentOffset.y)
            }
        }
        else if vertical_Slider_Responders.count == 0{
            print("responders.count == 0")
        }
    }
    
    

    let dimz = ComponentDimensions.StaticComponentDimensions
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = dimz.v_SliderCellWidth  //collectionView.frame.width / 3
        let height = dimz.v_SliderCellHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//    func addCellData(_ counter: Int) {
//        self.parent.v_Slider_Data.append(counter)
//    }

}
