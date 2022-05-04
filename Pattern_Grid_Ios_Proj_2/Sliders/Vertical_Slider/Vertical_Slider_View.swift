

import Foundation
import SwiftUI
import UIKit

struct Vertical_Slider_View: UIViewRepresentable {

    var dimensions = ComponentDimensions.StaticComponentDimensions
    
    var v_Slider_Data : [Int] = []
    
    var vSliderResponderArray : [P_VSlider_Responder] = []
    
    init(vSliderResponderArrayParam : [P_VSlider_Responder],vertical_Slider_Coordinator_Param : Vertical_Slider_Coordinator_Store){
        
        //print("Vertical_Slider_View init in innit mate")
        
        vertical_Slider_Coordinator_Store = vertical_Slider_Coordinator_Param
        
        vSliderResponderArray = vSliderResponderArrayParam

        let vSliderStart : Int = dimensions.returnGridVerticalStart()
        let vSliderEnd : Int = dimensions.returnGridVerticalEnd()

        for i in vSliderStart..<vSliderEnd {
            v_Slider_Data.append(i)
        }
        
        for vResponder in vSliderResponderArrayParam {
            vertical_Slider_Coordinator_Param.vertical_Slider_Responders.append(vResponder)
        }
        
//        for hResponder in hSliderResponderArrayParam {
//        horizontal_Slider_Coordinator_Store_Param.h_responders.append(hResponder)
//        }

    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
    
    var vertical_Slider_Coordinator_Store : Vertical_Slider_Coordinator_Store
    
    func makeCoordinator() -> Vertical_Slider_Coordinator_Store {
        //Coordinator(self)
//        let cd = Coordinator(self)
//        for vSliderResponder in vSliderResponderArray{
//            cd.responders.append(vSliderResponder)
//        }
//        return cd
        
        print("makeCoordinator() called in V_Slider")
        return vertical_Slider_Coordinator_Store
    }
    
    
}



extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}



