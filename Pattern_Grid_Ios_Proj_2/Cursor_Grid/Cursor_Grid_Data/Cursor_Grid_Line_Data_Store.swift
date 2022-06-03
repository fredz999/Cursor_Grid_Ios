//
//  Cursor_Grid_Cell_Data_Line.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 29/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Line_Data_Store : ObservableObject, Identifiable {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    //let lclColors = ComponentColors.StaticComponentColors
    let lclColorProcessor2 = Color_Processor_Mk_2.Static_Color_Processor_Mk_2
    var id = UUID()
    var place_In_Parent_Line_Array : Int
    var cell_Data_Array : [Cursor_Grid_Cell_Data_Store] = []
    var parentGridData : Cursor_Grid_Data_Store?
    
    //var currentCursor_X_Num : Int?

    
    init(lineNumberParam:Int){
        place_In_Parent_Line_Array = lineNumberParam
        setChildren()
    }
    
    func setChildren(){
        for x in 0..<lclDimensions.numberCellsGridHorizontal {
        let data = Cursor_Grid_Cell_Data_Store(xParam: x, yParam: place_In_Parent_Line_Array)
        data.setParentLineData(parentDataLineParam: self)
        //lclColors.status_Cell_Painter.color_Processor.color_Evaluation_Cursor(cellDataParam: data)
            //lclColorProcessor2.
        cell_Data_Array.append(data)
        }
    }
    
    func setParentGridData(parentGridParam:Cursor_Grid_Data_Store){
        if parentGridData == nil{parentGridData = parentGridParam}
    }
    
}
