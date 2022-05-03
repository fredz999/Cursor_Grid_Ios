//
//  H_Slider_Responder_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 02/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Horizontal_Slider_Responder_Store : ObservableObject, P_HSlider_Responder {
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var cursor_Grid_Data : Cursor_Grid_Data_Store?
    
    var current_X_Bracket : Int?{
        didSet {
            if let lclCurrent_X_Bracket = current_X_Bracket{

                if let lclGrid_Data = cursor_Grid_Data{
                    lclGrid_Data.update_Data_Cursor_X(new_Cursor_X_Int: lclCurrent_X_Bracket)
                }
                
            }
        }
    }
    
    func react_To_Swiper_X(x_OffsetParam: CGFloat) {
        //print("x_OffsetParam: ",x_OffsetParam.description,", dimz cell width: ",lclDimensions.gridUnitSize)
        let floatDivision = x_OffsetParam/lclDimensions.gridUnitSize
        let intDivision = Int(floatDivision)
        if current_X_Bracket != intDivision {
            current_X_Bracket = intDivision
        }
    }
    
    func scrollTaeEndReact(){
        
    }
    
}
