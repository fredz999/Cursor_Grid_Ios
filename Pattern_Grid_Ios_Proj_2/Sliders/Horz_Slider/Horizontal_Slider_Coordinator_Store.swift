//
//  Horizontal_Slider_Coordinator_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 02/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Horizontal_Slider_Coordinator_Store: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ObservableObject{
        
        let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
        var collection_View : UICollectionView?
    
        var faceVals : [Int] = []
    
        var horizontal_Slider_Responders : [P_HSlider_Responder] = []
    
        private var parent: Horizontal_Slider_View?

//        init(_ gridView: Horizontal_Slider_View) {
//            self.parent = gridView
//        }
    
        override init() {
            for x in 0..<lclDimensions.numberCellsSliderHorizontal{
                faceVals.append(x)
            }
        }

        // MARK: UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //self.parent.h_Slider_Data.count
            return ComponentDimensions.StaticComponentDimensions.numberCellsSliderHorizontal //numberCellsGridHorizontal
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let horizontal_Slider_Cell = Slider_Cell.getReusedCellFrom(collectionView: collectionView, cellForItemAt: indexPath)
            horizontal_Slider_Cell.backgroundColor = .lightGray
            if faceVals.count > indexPath.item{
                horizontal_Slider_Cell.labelText = faceVals[indexPath.item]    //0 //self.parent.h_Slider_Data[indexPath.item]
                horizontal_Slider_Cell.update()
            }
            
            return horizontal_Slider_Cell
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if horizontal_Slider_Responders.count > 0 {
                for res in horizontal_Slider_Responders {
                    res.react_To_Swiper_X(x_OffsetParam: scrollView.contentOffset.x)
                }
            }
        }

        

        let dimz = ComponentDimensions.StaticComponentDimensions

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = dimz.h_SliderCellWidth  //collectionView.frame.width / 3
            let height = dimz.h_SliderCellHeight
            return CGSize(width: width, height: height)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

//        func addCellData(_ counter: Int) {
//            self.parent.h_Slider_Data.append(counter)
//        }
    
//        func respondToBtn(){
//            print("respondToBtn jest octivateed, collection_View nil ? ",collection_View == nil ? "Y" : "N")
//        }
    
        func goToEnd(){
            let indexToScrollTo = IndexPath(item: 13, section: 0)
            if let lclCollection_View = collection_View{
                lclCollection_View.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            }
        }
    
}
