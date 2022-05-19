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
    
    var currentCursor_X_Num : Int?
//    {
//        didSet {
//            handleCursorChange()
//        }
//    }
    
    init(lineNumberParam:Int){
        place_In_Parent_Line_Array = lineNumberParam
        setChildren()
    }
    
    func setChildren(){
        for x in 0..<lclDimensions.numberCellsGridHorizontal {
        let data = Cursor_Grid_Cell_Data_Store(xParam: x, yParam: place_In_Parent_Line_Array)
        // let data = Cursor_Grid_Cell_Data_Store(xParam: invert_X(x_Param: x), yParam: place_In_Parent_Line_Array)
        data.setParentLineData(parentDataLineParam: self)
        lclColors.status_Cell_Painter.color_Processor.color_Evaluation_Cursor(cellDataParam: data)
        cell_Data_Array.append(data)
        }
    }
    
//    func invert_X(x_Param:Int)->Int{
//        let invertedIndex = lclDimensions.numberCellsGridHorizontal - (x_Param+1)
//        if place_In_Parent_Line_Array == 1{
//            print("x_Param: ",x_Param,", invertedIndex: ",invertedIndex)
//        }
//        return invertedIndex
//    }
    
    func setParentGridData(parentGridParam:Cursor_Grid_Data_Store){
        if parentGridData == nil{parentGridData = parentGridParam}
    }
    
//    func return_Inverse_Cell(x_Param:Int)->Cursor_Grid_Cell_Data_Store {
//        let invertedIndex = lclDimensions.numberCellsGridHorizontal - (x_Param+1)
//        return cell_Data_Array[invertedIndex]
//    }
    
    //func handleCursorChange(){}
    
    var in_Line_Cursor_Cell : Cursor_Grid_Cell_Data_Store?
    {
        didSet {
            if let lcl_In_Line_Cell = in_Line_Cursor_Cell {
                lcl_In_Line_Cell.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
            }
        }
    }
    
    //var current_Cursor_X_Int : Int = 0
    
    func set_In_Line_Cursor_Cell(xParam:Int){
        //print("set_In_Line_Cursor_Cell(), y: ", place_In_Parent_Line_Array,", currX: ",current_Cursor_X_Int)
        //print("huh?, xParam: ",xParam.des)
        in_Line_Cursor_Cell = cell_Data_Array[xParam]
    }
    
    func nil_In_Line_Cursor_Cell(){
        if let lclin_Line_Cursor_Cell = in_Line_Cursor_Cell{
            lclin_Line_Cursor_Cell.processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
            in_Line_Cursor_Cell = nil
        }
    }
    
    
    
    
}
