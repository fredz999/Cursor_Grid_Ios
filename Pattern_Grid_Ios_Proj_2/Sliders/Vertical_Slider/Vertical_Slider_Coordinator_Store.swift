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
    
    let lcldimensions = ComponentDimensions.StaticComponentDimensions
    
    var vertical_Slider_Responders : [P_VSlider_Responder] = []
    
     init(vSliderResponderArrayParam : [P_VSlider_Responder]){
        for vResponder in vSliderResponderArrayParam {
            vertical_Slider_Responders.append(vResponder)
        }
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    }
    
    let dimz = ComponentDimensions.StaticComponentDimensions
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = dimz.v_SliderCellWidth
        let height = dimz.v_SliderCellHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    var v_Collection_View : UICollectionView?
    
    func toggleFreeze(toFreeze : Bool) {
        if toFreeze == true {
            if let lclV_Collection_View = v_Collection_View {
                lclV_Collection_View.isScrollEnabled = false
            }
        }
        else if toFreeze == false {
            if let lclV_Collection_View = v_Collection_View {
                lclV_Collection_View.isScrollEnabled = true
            }
        }
    }
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    func vertical_GoToEnd(){
        
        let last = lclDimensions.useable_Data_Range_Upper_Limit-1
        print("vertical_GoToEnd(), last: ",last.description)
        let indexToScrollTo = IndexPath(item: 33, section: 0)
        
        if let lclCollection_View = v_Collection_View {
            lclCollection_View.scrollToItem(at: indexToScrollTo, at: .bottom, animated: false)
        }
        
    }

}
