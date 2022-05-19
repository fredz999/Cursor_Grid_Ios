//
//  Recursive_Set_Manager.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 14/05/2022.
//

import Foundation
import SwiftUI
import Combine


class Recursive_Set_Manager {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    var parent_Note_Writer: Note_Writer?
    
    var all_The_Cells_Of_The_Locked_Line : [Cursor_Grid_Cell_Data_Store]?

    var viable_Set_Formed : Bool = false
    
    var currentViableDataCellArray : [Cursor_Grid_Cell_Data_Store] = []
    
    var currentLowestViableCell_X_Index : Int?
    
    var currentHighestViableCell_X_Index : Int?
    
    // touchdown cell
    var starter_Cell_Index : Int?
    var current_Cell_Index : Int?
    
    // TODO: parallell state changes
    func nil_Viable_Set(){
        
//        if let parentNoteWriter = parent_Note_Writer {
//            if let parentData = parentNoteWriter.parentGridData {
//                if let lclCurrCell = parentData.currCellData {
//                    if currentViableDataCellArray.count != 0 {
//                        for sell in currentViableDataCellArray {
//                            if sell == lclCurrCell {
//                                sell.processSelectabilityUpdate(selectabilityUpdateParam: .not_In_A_Write_Viable_Group)
//                                sell.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                                sell.place_In_Viable_Set = nil
//                            }
//                            else if sell != lclCurrCell {
//                                sell.processSelectabilityUpdate(selectabilityUpdateParam: .not_In_A_Write_Viable_Group)
//                                sell.processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                                sell.place_In_Viable_Set = nil
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        currentLowestViableCell_X_Index = nil
        currentHighestViableCell_X_Index = nil
        starter_Cell_Index = nil
        current_Cell_Index = nil

        currentViableDataCellArray.removeAll()
        all_The_Cells_Of_The_Locked_Line = nil
        if viable_Set_Formed == true { viable_Set_Formed = false }
        
    }
    
    // this has to capture the start cell as well
    func define_Viable_Set(x_PlaceParam:Int){

        if let lclLocked_Line_Cell_Array = all_The_Cells_Of_The_Locked_Line {
            
            if checkTheCellIsWriteable(x_PlaceParam: x_PlaceParam, line_Cell_Array_Param: lclLocked_Line_Cell_Array) == true {
                drop_X_One_AndCheckAgain(int_To_Drop: x_PlaceParam)
                raise_X_One_AndCheckAgain(int_To_Raise: x_PlaceParam)
            }
            
            if let lclLow = currentLowestViableCell_X_Index
                , let lclHigh = currentHighestViableCell_X_Index {
                for x in lclLow...lclHigh {
                    
                    if lclLocked_Line_Cell_Array[x].xNumber == x_PlaceParam {
                        lclLocked_Line_Cell_Array[x].place_In_Viable_Set = currentViableDataCellArray.count
                        if starter_Cell_Index == nil, current_Cell_Index == nil {
                            starter_Cell_Index = currentViableDataCellArray.count
                            current_Cell_Index = currentViableDataCellArray.count
                        }
                    }
                    
                    else if lclLocked_Line_Cell_Array[x].xNumber != x_PlaceParam {
                        lclLocked_Line_Cell_Array[x].place_In_Viable_Set = currentViableDataCellArray.count
                    }
                    
                    currentViableDataCellArray.append(lclLocked_Line_Cell_Array[x])
                }
            }
            if currentViableDataCellArray.count > 0 {
                if viable_Set_Formed == false { viable_Set_Formed = true }
                for x in 0..<currentViableDataCellArray.count-1{
                    currentViableDataCellArray[x].place_In_Viable_Set = x
                }
            }
            
        }
    }
    
    func checkTheCellIsWriteable(x_PlaceParam:Int,line_Cell_Array_Param : [Cursor_Grid_Cell_Data_Store])->Bool{
        var retval = false
        if line_Cell_Array_Param[x_PlaceParam].note_Status == .unassigned ||
            line_Cell_Array_Param[x_PlaceParam].note_Status == .cursor_Passive ||
            line_Cell_Array_Param[x_PlaceParam].note_Status == .cursor_Active_Writable {
            retval = true
        }
        return retval
    }
    
    func raise_X_One_AndCheckAgain(int_To_Raise:Int){
        if int_To_Raise <= lclDimensions.gridCellsHorizontalFinalIndex-1 {
            let newVal = int_To_Raise+1
            check_Higher_Termination_Criteria(valueToCheck: newVal)
        }
        else if int_To_Raise == lclDimensions.gridCellsHorizontalFinalIndex {
            if currentHighestViableCell_X_Index == nil {
                currentHighestViableCell_X_Index = lclDimensions.gridCellsHorizontalFinalIndex
            }
        }
    }
    
    func drop_X_One_AndCheckAgain(int_To_Drop:Int){
        if int_To_Drop >= 1 {
            let newVal = int_To_Drop-1
            check_Lower_Termination_Criteria(valueToCheck: newVal)
        }
        else if int_To_Drop == 0 {
            if currentLowestViableCell_X_Index == nil {
            currentLowestViableCell_X_Index = 0
            }
        }
    }
    
    func check_Higher_Termination_Criteria(valueToCheck: Int) {
        if let lclLocked_Line_Cell_Array = all_The_Cells_Of_The_Locked_Line {
            if lclLocked_Line_Cell_Array[valueToCheck].note_Status != .unassigned {
                if currentHighestViableCell_X_Index == nil {
                    currentHighestViableCell_X_Index = valueToCheck-1
                }
            }
            else if lclLocked_Line_Cell_Array[valueToCheck].note_Status == .unassigned {
                raise_X_One_AndCheckAgain(int_To_Raise: (valueToCheck))
            }
        }
    }
    
    func check_Lower_Termination_Criteria(valueToCheck: Int) {
        if let lclLocked_Line_Cell_Array = all_The_Cells_Of_The_Locked_Line {
            if lclLocked_Line_Cell_Array[valueToCheck].note_Status != .unassigned {
                if currentLowestViableCell_X_Index == nil {
                    currentLowestViableCell_X_Index = valueToCheck+1
                }
            }
            else if lclLocked_Line_Cell_Array[valueToCheck].note_Status == .unassigned {
                drop_X_One_AndCheckAgain(int_To_Drop: (valueToCheck))
            }
        }
    }
    
}
