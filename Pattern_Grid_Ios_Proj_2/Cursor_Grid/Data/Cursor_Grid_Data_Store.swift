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

                if noteWritingActivated == true {
                    note_UpDate_Handler()
                }

            }
        }
    }
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int){
        if new_Cursor_X_Int >= 0, new_Cursor_X_Int <  lclDimensions.numberCellsGridHorizontal{
            if new_Cursor_X_Int != current_Cursor_X_Int {
                
                if let lclcurrentCursorData = currentCursorData{lclcurrentCursorData.isCurrentCursor = false}
                
                current_Cursor_X_Int = new_Cursor_X_Int
                currentCursorData = cell_Line_Array[current_Cursor_Y_Int].select_Cell(cellIndex: new_Cursor_X_Int)

                if noteWritingActivated == true {
                    note_UpDate_Handler()
                }
                
            }
        }
    }
    
    var noteWritingActivated : Bool = false
    
    func note_UpDate_Handler(){
    print("note_UpDate_Handler() was activated, currX:",current_Cursor_X_Int,", currY: ",current_Cursor_Y_Int)
        
        let currCellData = cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array
     
        
    }
    // 0: lock the line
    // 1 : establish the set of selectable cells (if any)
    // 2: from within the set of selectable cells make two sets - set1: (from left to right) set2:(outside left to right) : set2 is selectable
    // perhaps unselectable = dark red color scheme
    // selectable : bright red color scheme
    // set1(l-r) : orange color scheme (potential notes)
    
    // 1: add cell to note () - for line of notes - paint them orange and give them the appropriate statuses/perimeters
    
    
}


