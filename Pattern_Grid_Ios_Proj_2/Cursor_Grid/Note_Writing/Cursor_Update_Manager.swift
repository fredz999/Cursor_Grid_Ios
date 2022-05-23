//
//  Cursor_Update_Manager.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 19/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Update_Manager {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    var parent_Grid_Data_Store : Cursor_Grid_Data_Store?

    var current_Cursor_Line : Cursor_Grid_Line_Data_Store? {
        willSet {
            nil_In_Line_Cursor_Cell()
        }
        didSet {
            set_Current_Cursor_Cell(xParam: current_Cursor_X_Int)
        }
    }

    var current_Cursor_Cell : Cursor_Grid_Cell_Data_Store?
    {
        didSet {
            if let lcl_In_Line_Cell = current_Cursor_Cell {
                lcl_In_Line_Cell.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
            }
        }
    }
    
    func set_Current_Cursor_Cell(xParam:Int){
        if let lcl_current_Cursor_Line = current_Cursor_Line {
            current_Cursor_Cell = lcl_current_Cursor_Line.cell_Data_Array[xParam]
        }
    }
    
    func nil_In_Line_Cursor_Cell(){
        if let lclin_Line_Cursor_Cell = current_Cursor_Cell{
            lclin_Line_Cursor_Cell.processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
            current_Cursor_Cell = nil
        }
    }
    
    var current_Cursor_X_Int : Int = 0
    
    var current_Cursor_Y_Int : Int = 0

    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int) {
                if let lclParent = parent_Grid_Data_Store {
                if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= lclParent.cell_Line_Array.count {
                if new_Cursor_Y_Int != current_Cursor_Y_Int {
                current_Cursor_Y_Int = new_Cursor_Y_Int
                current_Cursor_Line = lclParent.cell_Line_Array[new_Cursor_Y_Int]
                }
            }
        }
    }
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
        
        if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
            
            if new_Cursor_X_Int != current_Cursor_X_Int {
            nil_In_Line_Cursor_Cell()
            current_Cursor_X_Int = new_Cursor_X_Int
            set_Current_Cursor_Cell(xParam: current_Cursor_X_Int)
                
                
      
 
            if let lclParentGrid = parent_Grid_Data_Store {

                if lclParentGrid.noteWritingActivated == true   {
                    
                    if lclParentGrid.viable_Set_Manager.viable_Set_Formed == true{
                        if let lclHigher = lclParentGrid.viable_Set_Manager.currentHighestViableCell_X_Index
                            , let lclLower = lclParentGrid.viable_Set_Manager.currentLowestViableCell_X_Index {
                            if current_Cursor_X_Int > lclHigher || current_Cursor_X_Int < lclLower {
                                lclParentGrid.viable_Set_Manager.nil_Viable_Set()
                            }
                            // TODO: note write
                            else if current_Cursor_X_Int <= lclHigher , current_Cursor_X_Int >= lclLower{
                                print("possible mid write event happenin in the cursor update manager")
                            }
                        }
                    }
                    else if lclParentGrid.viable_Set_Manager.viable_Set_Formed == false, let lclCurrCell = current_Cursor_Cell{
                        if lclCurrCell.note_Status != .confirmedSingle || lclCurrCell.note_Status != .confirmedStart
                            || lclCurrCell.note_Status != .confirmedMiddle || lclCurrCell.note_Status != .confirmedEnd{
                            lclParentGrid.viable_Set_Manager.define_Viable_Set(cellParam: lclCurrCell)
                            // TODO: note write
                            print("possible start write event happenin in the cursor update manager")
                        }
                    }
                    
               
                    
                    
                }
            }
             
                
                
                
            }
        }
        
    }
    

}













// ========================================historic stuff==================================

//func update_Data_Cursor_Y(new_Cursor_Y_Int:Int){
//    if let lclParent = parent_Grid_Data_Store {
//
//        if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= lclParent.cell_Line_Array.count {
//
//            if new_Cursor_Y_Int != current_Cursor_Y_Int {
//
//                current_Cursor_Y_Int = new_Cursor_Y_Int
//
//                current_Cursor_Line = lclParent.cell_Line_Array[new_Cursor_Y_Int]
//
//                //currCellData = cell_Line_Array[new_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)
//
//                //current_Cursor_Line = new_Cursor_Y_Int
//
////                if noteWritingActivated == true {
////                    note_UpDate_Handler()
////                }
////
////                else if noteWritingActivated == false {
//
////                    if let lclCurrData = currCellData {
////                        lclCurrData.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
////                    }
//
//
////                }
//    }
//
//
//        }
//    }
//}




//func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
//    if let lclParent = parent_Grid_Data_Store {
//        if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
//
//            if new_Cursor_X_Int != current_Cursor_X_Int {
//
//            lclParent.cell_Line_Array[current_Cursor_Y_Int].nil_In_Line_Cursor_Cell()
//
//            current_Cursor_X_Int = new_Cursor_X_Int
//
//            if let lclCurr_Line = current_Cursor_Line {
//                lclCurr_Line.set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)
//            }
//
//            //current_Cursor_Line.set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)
//
//            //lclParent.cell_Line_Array[current_Cursor_Y_Int].set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)
//
//            }
//
//        }
//    }
//}