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
    let lclColors = ComponentColors.StaticComponentColors
    var id = UUID()
    var place_In_Parent_Line_Array : Int
    var cell_Data_Array : [Cursor_Grid_Cell_Data_Store] = []
    var parentGridData : Cursor_Grid_Data_Store?
    
    init(lineNumberParam:Int){
        place_In_Parent_Line_Array = lineNumberParam
        setChildren()
    }
    
    func setChildren(){
        for x in 0..<lclDimensions.numberCellsGridHorizontal {
        let data = Cursor_Grid_Cell_Data_Store(xParam: x, yParam: place_In_Parent_Line_Array)
        data.setParentLineData(parentDataLineParam: self)
        lclColors.status_Cell_Painter.selectColorConfig(cellDataParam: data)
        cell_Data_Array.append(data)
        }
    }
    
    func setParentGridData(parentGridParam:Cursor_Grid_Data_Store){
        parentGridData = parentGridParam
    }
    
    func return_Inverse_Cell(x_Param:Int)->Cursor_Grid_Cell_Data_Store {
        let invertedIndex = lclDimensions.numberCellsGridHorizontal - (x_Param+1)
        return cell_Data_Array[invertedIndex]
    }
    
}
