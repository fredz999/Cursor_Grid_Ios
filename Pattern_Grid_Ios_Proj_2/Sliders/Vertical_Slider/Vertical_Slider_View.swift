

import Foundation
import SwiftUI
import UIKit

struct Vertical_Slider_View: UIViewRepresentable {

    var dimensions = ComponentDimensions.StaticComponentDimensions
    
    var v_Slider_Data : [Int] = []
    
    init(vSliderResponderArrayParam : [P_VSlider_Responder]){
        vSliderResponderArray = vSliderResponderArrayParam
        
        let vSliderStart : Int = dimensions.returnGridVerticalStart()
        let vSliderEnd : Int = dimensions.returnGridVerticalEnd()
        
        for i in vSliderStart..<vSliderEnd {
            v_Slider_Data.append(i)
        }

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
    
    func makeCoordinator() -> Vertical_Slider_Coordinator {
        //Coordinator(self)
        let cd = Coordinator(self)
        for vSliderResponder in vSliderResponderArray{
            cd.responders.append(vSliderResponder)
        }
        return cd
    }
    
    var vSliderResponderArray : [P_VSlider_Responder]=[]
}

class Vertical_Slider_Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        private var parent: Vertical_Slider_View
        //let kerSnoller: DragAndDropViewControoler = DragAndDropViewControoler()
        
        init(_ gridView: Vertical_Slider_View) {
            self.parent = gridView
        }

        // MARK: UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            self.parent.v_Slider_Data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let vertical_Slider_Cell = Slider_Cell.getReusedCellFrom(collectionView: collectionView, cellForItemAt: indexPath)
            vertical_Slider_Cell.backgroundColor = .lightGray
            vertical_Slider_Cell.counter = self.parent.v_Slider_Data[indexPath.item]
            vertical_Slider_Cell.update()
            return vertical_Slider_Cell
        }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if responders.count > 0 {
            for res in responders {
                res.react_To_Swiper_Y(y_OffsetParam: scrollView.contentOffset.y)
            }
        }
    }
    
    var responders : [P_VSlider_Responder] = []

        let dimz = ComponentDimensions.StaticComponentDimensions
        // MARK: UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = dimz.VSliderCellWidth  //collectionView.frame.width / 3
            let height = dimz.VSliderCellHeight
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func addCellData(_ counter: Int) {
            self.parent.v_Slider_Data.append(counter)
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

protocol P_VSlider_Responder{
    func react_To_Swiper_Y(y_OffsetParam: CGFloat)
}

