//
//  Horizontal_Slider_View.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 01/05/2022.
//

import Foundation
import SwiftUI
import Combine

struct Horizontal_Slider_View : UIViewRepresentable {
    
    var dimensions = ComponentDimensions.StaticComponentDimensions
    
    var h_Slider_Data : [Int] = [] //= [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    var hSliderResponderArray : [P_HSlider_Responder]=[]
    
    init(hSliderResponderArrayParam : [P_HSlider_Responder],horizontal_Slider_Coordinator_Store_Param : Horizontal_Slider_Coordinator_Store){
        horizontal_Slider_Coordinator_Store = horizontal_Slider_Coordinator_Store_Param
        hSliderResponderArray = hSliderResponderArrayParam
        
        for x in 0..<dimensions.numberCellsSliderHorizontal{
            h_Slider_Data.append(x)
        }
        
        for hResponder in hSliderResponderArrayParam {
        horizontal_Slider_Coordinator_Store_Param.responders.append(hResponder)
        }

    }
    
    func makeUIView(context: Context) -> UICollectionView {
        
        let flowLay = UICollectionViewFlowLayout()
        
        flowLay.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLay)
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        context.coordinator.collection_View = collectionView
        Slider_Cell.registerWithCollectionView(collectionView: collectionView)
        
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        //
    }
    
    var horizontal_Slider_Coordinator_Store : Horizontal_Slider_Coordinator_Store
    
    func makeCoordinator() -> Horizontal_Slider_Coordinator_Store {
//        let cd = Horizontal_Slider_Coordinator_Store(self)
//
//        for hResponder in hSliderResponderArray{
//        cd.responders.append(hResponder)
//        }
//        return cd
        return horizontal_Slider_Coordinator_Store
    }
    
    
}





