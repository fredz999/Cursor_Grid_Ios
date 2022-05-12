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
    
    var current_Cursor_Y_Int : Int = 0
    
    var current_Cursor_X_Int : Int = 0
    
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
        cell_Line_Array.append(line_Data)
        }
        currCellData = cell_Line_Array[0].return_Inverse_Cell(x_Param: 0)
        cell_Line_Array[0].cell_Data_Array[2].grid_Cell_Data_Note_Status = .confirmedSingle
        cell_Line_Array[0].cell_Data_Array[11].grid_Cell_Data_Note_Status = .confirmedSingle
        note_Writer.parentGridData = self
    }
    
    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int){
        if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= cell_Line_Array.count {
            
            if new_Cursor_Y_Int != current_Cursor_Y_Int {
                
                current_Cursor_Y_Int = new_Cursor_Y_Int
                
                currCellData = cell_Line_Array[new_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)

                if noteWritingActivated == true {
                    note_UpDate_Handler()
                }
                
                else if noteWritingActivated == false {
                    if let lclCurrData = currCellData {
                        lclCurrData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: nil)
                    }
                }
                
            }
        }
    }
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
        
        if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
            
            if new_Cursor_X_Int != current_Cursor_X_Int {

            current_Cursor_X_Int = new_Cursor_X_Int
            
            currCellData = cell_Line_Array[current_Cursor_Y_Int].return_Inverse_Cell(x_Param: new_Cursor_X_Int)

            if noteWritingActivated == true {
                note_UpDate_Handler()
            }
            
            else if noteWritingActivated == false {
                if let lclCurrData = currCellData {
                    lclCurrData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: nil)
                }
            }
                                
            }
        }
    }
    
    // TODO: parallell state changes
    var noteWritingActivated : Bool = false {
        didSet {
            
            if noteWritingActivated == true {
                note_UpDate_Handler()
            }
            
            else if noteWritingActivated == false {
                // print("pre nil viable set currentViableDataCellArray.count",note_Writer.recursive_Set_Manager.currentViableDataCellArray.count)
                note_Writer.recursive_Set_Manager.nil_Viable_Set()
                // set cursor - it will be prohib for the majority of cases
                if let lclCurrData = currCellData {
                    lclCurrData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: nil)
                }
                
                // hmm 0? ..... find oot why
                // print("note_Writer.recursive_Set_Manager.currentViableDataCellArray.count",note_Writer.recursive_Set_Manager.currentViableDataCellArray.count)
                // if there is a viable set then it has to have its member cells de - selected here
                
//                if note_Writer.recursive_Set_Manager.currentViableDataCellArray.count != 0 {
//                    for sell in note_Writer.recursive_Set_Manager.currentViableDataCellArray {
//                        if sell.selectability_Status != .selectability_Unassigned {
//                            sell.selectability_Status = .selectability_Unassigned
//                        }
//                    }
//                }
//                else {
//                    print("sdfvlsduibfvoisdfubvsdf")
//                }
                
                
            }
        }
    }
    
    // TODO: parallell state changes
    var currCellData : Cursor_Grid_Cell_Data_Store? {
        willSet {
            if let lclCurrCellData = currCellData {
                if lclCurrCellData.status_Before_I_Became_The_Cursor != nil{
                    lclCurrCellData.restoreToPreCursor()
                }
            }
        }
    }
    
    func note_UpDate_Handler() {

        
            if note_Writer.recursive_Set_Manager.all_The_Cells_Of_The_Locked_Line == nil {
                note_Writer.recursive_Set_Manager.all_The_Cells_Of_The_Locked_Line = cell_Line_Array[current_Cursor_Y_Int].cell_Data_Array
            }
        
            if note_Writer.recursive_Set_Manager.currentViableDataCellArray.count == 0 {
                if let _ = note_Writer.recursive_Set_Manager.all_The_Cells_Of_The_Locked_Line {
                let invCell = cell_Line_Array[current_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)
                note_Writer.recursive_Set_Manager.define_Viable_Set(x_PlaceParam: invCell.xNumber)
                }
            }
        
            else if note_Writer.recursive_Set_Manager.currentViableDataCellArray.count != 0 {
                if let lclLower = note_Writer.recursive_Set_Manager.currentLowestViableCell_X_Index
                , let lclUpper = note_Writer.recursive_Set_Manager.currentHighestViableCell_X_Index {
                    
                    if let lclCurrData = currCellData {
                        if lclCurrData.xNumber >= lclLower, lclCurrData.xNumber <= lclUpper {
                            
                            // lclCurrData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .selectable)
                            // may 13th
                            // write in here but only refer to the cells within the viable list and ...ok were already within the
                            // viable upper and lower limits.....
                            lclCurrData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .cursor_Active_Writable)
                            //print("we need a write in here")
                        }
                        else {
                            // may 13th contd ...
                            // figure oot why the out commented stuff in here only does prohib after the cursor leaves
                            // and why it dosent get put back to normal after the cursor goes out
                            lclCurrData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .cursor_Active_Prohibited)
                            //print("either there needs to be a prohib, or a viable array re-definition")
                        }
                    }

                }

            }

        
            //2: choose from within the locked line viable list
            // 2-1: ascertain the lowerX
            // 2-2: ascertain the upperX
            // construct the potentialArray from within the viableCellArray within the lockedLine and limited
            // by these two element numbers - (index numbers from the viable array)
            // currently the lowerX and upperX and viable array are in the line object
            // they need to be in the note writer I think

    }
    
    var note_Writer : Note_Writer = Note_Writer()
    
}
