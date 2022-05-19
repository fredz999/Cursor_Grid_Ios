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
    
    
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    let lclColors = ComponentColors.StaticComponentColors
    
    var cell_Line_Array : [Cursor_Grid_Line_Data_Store] = []
    
    init(){
        setChildren()
    }
    
    func setChildren(){
        
        for y in 0..<lclDimensions.returnGridVerticalEnd(){
        let line_Data = Cursor_Grid_Line_Data_Store(lineNumberParam: y)
        line_Data.setParentGridData(parentGridParam: self)
        //line_Data.set_In_Line_Cursor_Cell(xParam: current_Cursor_Y_Int)
        cell_Line_Array.append(line_Data)
        }
        
        currCellData = cell_Line_Array[0].cell_Data_Array[current_Cursor_X_Int]          //.return_Inverse_Cell(x_Param: 0)
        //update_Data_Cursor_Y(new_Cursor_Y_Int: 0)
        
//        cell_Line_Array[0].cell_Data_Array[2].note_Status = .confirmedSingle
//        cell_Line_Array[0].cell_Data_Array[11].note_Status = .confirmedSingle
        
        current_Cursor_Line = cell_Line_Array[0]
        
        note_Writer.parentGridData = self
        
        
    }
    
    var current_Cursor_Line : Cursor_Grid_Line_Data_Store?
    {
        willSet {
            if let lcl_current_Cursor_Line = current_Cursor_Line {
                lcl_current_Cursor_Line.nil_In_Line_Cursor_Cell()
            }
        }
        didSet {
            if let lcl_current_Cursor_Line = current_Cursor_Line {
                lcl_current_Cursor_Line.set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)
            }
        }
    }

    var current_Cursor_Y_Int : Int = 0
    
    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int){

        if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= cell_Line_Array.count {
            
            if new_Cursor_Y_Int != current_Cursor_Y_Int {
                
                current_Cursor_Y_Int = new_Cursor_Y_Int
                
                current_Cursor_Line = cell_Line_Array[new_Cursor_Y_Int]
                
                //currCellData = cell_Line_Array[new_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)

                //current_Cursor_Line = new_Cursor_Y_Int
                
//                if noteWritingActivated == true {
//                    note_UpDate_Handler()
//                }
//                
//                else if noteWritingActivated == false {
                
//                    if let lclCurrData = currCellData {
//                        lclCurrData.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                    }
                
                
//                }
                
            }
        }
    }
    
    var current_Cursor_X_Int : Int = 0
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {

        if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
            
            if new_Cursor_X_Int != current_Cursor_X_Int {
                
            cell_Line_Array[current_Cursor_Y_Int].nil_In_Line_Cursor_Cell()

            current_Cursor_X_Int = new_Cursor_X_Int
                
            cell_Line_Array[current_Cursor_Y_Int].set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)

            }

        }
    }
    
//    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
//
//        if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
//
//            if new_Cursor_X_Int != current_Cursor_X_Int {
//
//            current_Cursor_X_Int = new_Cursor_X_Int
//
//            currCellData = cell_Line_Array[current_Cursor_Y_Int].return_Inverse_Cell(x_Param: new_Cursor_X_Int)
//
//            if noteWritingActivated == true {
//                note_UpDate_Handler()
//            }
//
//            else if noteWritingActivated == false {
//                if let lclCurrData = currCellData {
//                    lclCurrData.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                }
//            }
//
//            }
//        }
//    }
    
    var noteWritingActivated : Bool = false {
        didSet {
            
            if noteWritingActivated == true {
                note_UpDate_Handler()
            }
            
            else if noteWritingActivated == false {
                note_Writer.react_To_Write_Off()
                note_Writer.recursive_Set_Manager.nil_Viable_Set()
//                if let lclCurrData = currCellData {
//                    lclCurrData.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                }
            }
        }
    }
    
    var currCellData : Cursor_Grid_Cell_Data_Store?
//    {
//        willSet {
//            if let lclCurrCellData = currCellData {
//                if lclCurrCellData.cursor_Status == .is_The_Current_Cursor {
//                    lclCurrCellData.cursor_Status = .not_The_Current_Cursor
//                }
//            }
//        }
//    }
    
    func note_UpDate_Handler() {
//        if note_Writer.recursive_Set_Manager.all_The_Cells_Of_The_Locked_Line == nil {
//            note_Writer.recursive_Set_Manager.all_The_Cells_Of_The_Locked_Line = cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array
//        }
//    
//        if note_Writer.recursive_Set_Manager.currentViableDataCellArray.count == 0 {
//            //let invCell = cell_Line_Array[current_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)
//            
//            let invCell = cell_Line_Array[current_Cursor_Y_Int].in_Line_Cursor_Cell
//            
//            
//            if let _ = note_Writer.recursive_Set_Manager.all_The_Cells_Of_The_Locked_Line {
//            note_Writer.recursive_Set_Manager.define_Viable_Set(x_PlaceParam: invCell.xNumber)
//            }
//            
//            if let lclStarterIndex = note_Writer.recursive_Set_Manager.starter_Cell_Index {
//            note_Writer.consider_Cell_For_Addition(viable_Array_Index: lclStarterIndex)
//            }
//        }
//    
//        else if note_Writer.recursive_Set_Manager.currentViableDataCellArray.count != 0 {
//            if let lclLower = note_Writer.recursive_Set_Manager.currentLowestViableCell_X_Index
//            , let lclUpper = note_Writer.recursive_Set_Manager.currentHighestViableCell_X_Index {
//                if let lclCurrData = currCellData {
//                    if lclCurrData.xNumber >= lclLower, lclCurrData.xNumber <= lclUpper {
//                        if let lclViable_Set_Index = lclCurrData.place_In_Viable_Set {
//                            note_Writer.consider_Cell_For_Addition(viable_Array_Index: lclViable_Set_Index)
//                        }
//                    }
//                }
//            }
//        }
    }
    
    var note_Writer : Note_Writer = Note_Writer()
    
}
