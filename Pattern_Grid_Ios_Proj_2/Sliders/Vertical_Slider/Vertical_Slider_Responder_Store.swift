//
//  V_Slider_Responder_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 01/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Vertical_Slider_Responder_Store : ObservableObject, P_VSlider_Responder {

    var cursor_Grid_Data : Cursor_Grid_Data_Store?

    var cursor_Grid_Store : Cursor_Grid_Store?
    
    var currentLowVal : Int
    
    var previousLowVal : Int?

    var currentHighVal : Int
    
    var previousHighVal : Int?

    var dimensions = ComponentDimensions.StaticComponentDimensions

    init(){
        trackedInt = dimensions.returnGridVerticalStart()//.gridVertical_Start
        currentLowVal = dimensions.returnGridVerticalStart()//.gridVertical_Start
        currentHighVal = dimensions.returnGridVerticalStart()+dimensions.cursor_GridVerticalFinalIndex//.gridVertical_Start+dimensions.gridVerticalFinalIndex
    }

    var trackedInt : Int
    {
        didSet {
            
            
            if trackedInt >= dimensions.cursor_Grid_Movement_Lower_Limit
                ,trackedInt <= dimensions.cursor_Grid_Movement_Upper_Limit {

                previousLowVal = currentLowVal
                previousHighVal = currentHighVal

                currentLowVal = trackedInt
                currentHighVal = trackedInt + dimensions.cursor_GridVerticalFinalIndex

                updateLineStores_Main()
            }
            else if trackedInt >= dimensions.returnGridVerticalStart()
            ,trackedInt < dimensions.cursor_Grid_Movement_Lower_Limit || trackedInt > dimensions.cursor_Grid_Movement_Upper_Limit {
                
                previousLowVal = currentLowVal
                previousHighVal = currentHighVal

                currentLowVal = trackedInt
                currentHighVal = trackedInt + dimensions.cursor_GridVerticalFinalIndex

                updateLineStores_Cursor_Only()
                
            }

        }
    }

    func react_To_Swiper_Y(y_OffsetParam: CGFloat) {
        let yoffFloat = y_OffsetParam/dimensions.v_SliderCellHeight
        let yoffInt = Int(yoffFloat) + dimensions.returnGridVerticalStart()
        if yoffInt != trackedInt {
            trackedInt = yoffInt
        }
    }

    func updateLineStores_Main() {
        if let lclCursor_Grid_Store = cursor_Grid_Store, let lclCursor_Grid_Data = cursor_Grid_Data {
            lclCursor_Grid_Data.update_Data_Cursor_Y(new_Cursor_Y_Int: currentLowVal+dimensions.cursorOnlyAdjustment)
            lclCursor_Grid_Store.updateLineArrayPositions(currLowValParam: currentLowVal)
        }
    }

    func updateLineStores_Cursor_Only(){
        if let lclCursor_Grid_Data = cursor_Grid_Data {
            if currentLowVal+dimensions.cursorOnlyAdjustment < lclCursor_Grid_Data.cell_Line_Array.count {
                lclCursor_Grid_Data.update_Data_Cursor_Y(new_Cursor_Y_Int: currentLowVal+dimensions.cursorOnlyAdjustment)
            }
        }
    }
    



}
