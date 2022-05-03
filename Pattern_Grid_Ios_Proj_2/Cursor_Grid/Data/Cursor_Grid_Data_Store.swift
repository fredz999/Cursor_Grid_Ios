//
//  Cursor_Grid_Data.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 27/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Data_Store : ObservableObject {
    
    var currentCursorData : Cursor_Grid_Cell_Data_Store?
    
    var current_Cursor_Y_Int : Int = 0
    
    var current_Cursor_X_Int : Int = 0
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    var cell_Line_Array : [Cursor_Grid_Line_Data_Store] = []
    
    init(){
        for y in 0..<lclDimensions.returnGridVerticalEnd(){
            let data = Cursor_Grid_Line_Data_Store(lineNumberParam: y)
            cell_Line_Array.append(data)
        }
        currentCursorData = cell_Line_Array[0].cell_Data_Array[0]
        cell_Line_Array[0].cell_Data_Array[0].isCurrentCursor = true
    }
    
    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int){
        if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= cell_Line_Array.count{
            if new_Cursor_Y_Int != current_Cursor_Y_Int {
                
                if let lclcurrentCursorData = currentCursorData{ lclcurrentCursorData.isCurrentCursor = false }
                current_Cursor_Y_Int = new_Cursor_Y_Int
                currentCursorData = cell_Line_Array[new_Cursor_Y_Int].select_Cell(cellIndex: current_Cursor_X_Int)
                
//                currentCursorData = cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array[current_Cursor_X_Int]
//                cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array[current_Cursor_X_Int].isCurrentCursor = true
                
            }
        }
    }
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int){
        if new_Cursor_X_Int >= 0, new_Cursor_X_Int <  lclDimensions.numberCellsGridHorizontal{
            if new_Cursor_X_Int != current_Cursor_X_Int {
                
                if let lclcurrentCursorData = currentCursorData{lclcurrentCursorData.isCurrentCursor = false}
                
                current_Cursor_X_Int = new_Cursor_X_Int
                currentCursorData = cell_Line_Array[current_Cursor_Y_Int].select_Cell(cellIndex: new_Cursor_X_Int)
                
                //currentCursorData = cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array[current_Cursor_X_Int]
                //cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array[current_Cursor_X_Int].isCurrentCursor = true
                
                
            }
        }
    }
    
}


