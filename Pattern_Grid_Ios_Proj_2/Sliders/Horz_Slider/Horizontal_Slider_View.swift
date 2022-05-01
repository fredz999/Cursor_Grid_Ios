//
//  Horizontal_Slider_View.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 01/05/2022.
//

import Foundation
import SwiftUI
import Combine


struct Horizontal_Slider_View: UIViewRepresentable {

    var dimensions = ComponentDimensions.StaticComponentDimensions
    
    var h_Slider_Data : [Int] = [] //= [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    var hSliderResponderArray : [P_HSlider_Responder]=[]
    
    init(hSliderResponderArrayParam : [P_HSlider_Responder]){
        hSliderResponderArray = hSliderResponderArrayParam
        // numberCellsSliderHorizontal
        for x in 0..<dimensions.numberCellsSliderHorizontal{
            h_Slider_Data.append(x)
        }
//        let vSliderStart : Int = dimensions.returnGridVerticalStart()
//        let vSliderEnd : Int = dimensions.returnGridVerticalEnd()
//
//        for i in vSliderStart..<vSliderEnd {
//            h_Slider_Data.append(i)
//        }

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
 
        Slider_Cell.registerWithCollectionView(collectionView: collectionView)
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        //
    }
    
    func makeCoordinator() -> Horizontal_Slider_Coordinator {
        let cd = Horizontal_Slider_Coordinator(self)
        for hResponder in hSliderResponderArray{
            cd.responders.append(hResponder)
        }
        return cd
    }
    
    
}

class Horizontal_Slider_Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        private var parent: Horizontal_Slider_View

        init(_ gridView: Horizontal_Slider_View) {
            self.parent = gridView
        }

        // MARK: UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            self.parent.h_Slider_Data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let horizontal_Slider_Cell = Slider_Cell.getReusedCellFrom(collectionView: collectionView, cellForItemAt: indexPath)
            horizontal_Slider_Cell.backgroundColor = .lightGray
            horizontal_Slider_Cell.counter = self.parent.h_Slider_Data[indexPath.item]
            horizontal_Slider_Cell.update()
            return horizontal_Slider_Cell
        }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrollViewDidScroll, responders.count: ",responders.count.description)
        if responders.count > 0 {
            for res in responders {
                res.react_To_Swiper_X(x_OffsetParam: scrollView.contentOffset.x)
            }
        }
    }

    var responders : [P_HSlider_Responder] = []

        let dimz = ComponentDimensions.StaticComponentDimensions
        // MARK: UICollectionViewDelegateFlowLayout

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = dimz.HSliderCellWidth  //collectionView.frame.width / 3
            let height = dimz.HSliderCellHeight
            return CGSize(width: width, height: height)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func addCellData(_ counter: Int) {
            self.parent.h_Slider_Data.append(counter)
        }
    }


protocol P_HSlider_Responder{
    func react_To_Swiper_X(x_OffsetParam: CGFloat)
}

