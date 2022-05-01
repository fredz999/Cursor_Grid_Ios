//
//  V_Slider_Responder_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 01/05/2022.
//

import Foundation
import SwiftUI
import Combine

class V_Slider_Responder_Store : ObservableObject, P_VSlider_Responder {

    var cursor_Grid_Data : Cursor_Grid_Data?

    var cursor_Grid_Store : Cursor_Grid_Store?

    @Published var currentLowVal : Int
    @Published var previousLowVal : Int?

    @Published var currentHighVal : Int
    @Published var previousHighVal : Int?

    var dimensions = ComponentDimensions.StaticComponentDimensions

    init(){
        trackedInt = dimensions.returnGridVerticalStart()//.gridVertical_Start
        currentLowVal = dimensions.returnGridVerticalStart()//.gridVertical_Start
        currentHighVal = dimensions.returnGridVerticalStart()+dimensions.gridVerticalFinalIndex//.gridVertical_Start+dimensions.gridVerticalFinalIndex
    }

    var trackedInt : Int {
        didSet {
            if trackedInt >= dimensions.central_Grid_Movement_Lower_Limit
                ,trackedInt <= dimensions.central_Grid_Movement_Upper_Limit {

//                print("central: tracked int: ",trackedInt, ", lower limit: "
//                , dimensions.central_Grid_Movement_Lower_Limit,", upper limit: "
//                , dimensions.central_Grid_Movement_Upper_Limit)

                previousLowVal = currentLowVal
                previousHighVal = currentHighVal

                currentLowVal = trackedInt
                currentHighVal = trackedInt + dimensions.gridVerticalFinalIndex

                updateLineStores_Main()
            }
            else if trackedInt >= dimensions.returnGridVerticalStart()  //.gridVertical_Start
            ,trackedInt < dimensions.central_Grid_Movement_Lower_Limit || trackedInt > dimensions.central_Grid_Movement_Upper_Limit {
                //else if trackedInt < dimensions.central_Grid_Movement_Lower_Limit || trackedInt > dimensions.central_Grid_Movement_Upper_Limit {

//                print("cursor only: tracked int: ",trackedInt, ", lower limit: "
//                , dimensions.central_Grid_Movement_Lower_Limit,", upper limit: "
//                , dimensions.central_Grid_Movement_Upper_Limit)

                previousLowVal = currentLowVal
                previousHighVal = currentHighVal

                currentLowVal = trackedInt
                currentHighVal = trackedInt + dimensions.gridVerticalFinalIndex

                updateLineStores_Cursor_Only()
            }
        }
    }

    func react_To_Swiper_Y(y_OffsetParam: CGFloat) {
        let yoffFloat = y_OffsetParam/dimensions.VSliderCellHeight
        let yoffInt = Int(yoffFloat) + dimensions.returnGridVerticalStart()//.gridVertical_Start
        if yoffInt != trackedInt {
            trackedInt = yoffInt
        }
    }

    func updateLineStores_Main() {
        if let lclCursor_Grid_Store = cursor_Grid_Store, let lclCursor_Grid_Data = cursor_Grid_Data {
            // print("updateLineStores_Main: ",currentLowVal.description)
            // lclCursor_Grid_Data.update_Data_Cursor_Y(new_Cursor_Y_Int: currentLowVal)
            lclCursor_Grid_Data.update_Data_Cursor_Y(new_Cursor_Y_Int: currentLowVal+dimensions.cursorOnlyAdjustment)//+2)
            lclCursor_Grid_Store.updateLineArrayPositions(currLowValParam: currentLowVal)
        }
    }

    func updateLineStores_Cursor_Only(){
        //print("updateLineStores_Cursor_Only: ",currentLowVal.description)
        if let lclCursor_Grid_Data = cursor_Grid_Data {
            lclCursor_Grid_Data.update_Data_Cursor_Y(new_Cursor_Y_Int: currentLowVal+dimensions.cursorOnlyAdjustment)//
        }
    }


}
