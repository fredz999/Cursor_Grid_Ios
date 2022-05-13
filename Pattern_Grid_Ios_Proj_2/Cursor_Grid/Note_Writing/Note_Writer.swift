//
//  Note_Writer.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 09/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Note_Writer {
    
    var parentGridData : Cursor_Grid_Data_Store?
    
    var recursive_Set_Manager : Recursive_Set_Manager   //= Recursive_Set_Manager()
    
    var current_potentialNoteCellArray : [Cursor_Grid_Cell_Data_Store] = []
    
    init(){
        recursive_Set_Manager = Recursive_Set_Manager()
        setupChildren()
    }
    
    func setupChildren(){
        recursive_Set_Manager.parent_Note_Writer = self
    }
    
    func setStatus_Of_Member_Cells(){
        
        if current_potentialNoteCellArray.count == 1{
            current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialSingle)
        }
        else if current_potentialNoteCellArray.count == 2{
            
            let xNumStart = current_potentialNoteCellArray[0].xNumber
            let xNumEnd = current_potentialNoteCellArray[1].xNumber
            
            if xNumStart < xNumEnd {
                current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialStart)
                current_potentialNoteCellArray[1].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialEnd)
            }
            else if xNumStart > xNumEnd {
                current_potentialNoteCellArray[1].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialStart)
                current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialEnd)
            }
            
            
        }
        
        else if current_potentialNoteCellArray.count > 2 {
            
              let finalIndex = current_potentialNoteCellArray.count-1
              let xNumStart = current_potentialNoteCellArray[0].xNumber
              let xNumEnd = current_potentialNoteCellArray[finalIndex].xNumber
              if xNumStart < xNumEnd{
                current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialStart)
                for i in 1..<finalIndex{
                    current_potentialNoteCellArray[i].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialMiddle)
                }
                current_potentialNoteCellArray[finalIndex].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialEnd)
            }
            if xNumStart > xNumEnd{
                current_potentialNoteCellArray[finalIndex].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialStart)
                for i in 1..<finalIndex{
                    current_potentialNoteCellArray[i].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialMiddle)
                }
                current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialEnd)
            }
              
        }
    }
    

    func commit_Note(currCell:Cursor_Grid_Cell_Data_Store){
        
//        for cell in current_potentialNoteCellArray {
//
//            if cell == currCell {
//                if cell.note_Status == .potentialSingle {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedSingle)
//                }
//                else if cell.note_Status == .potentialStart {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedStart)
//                }
//                // TODO: Check if this is in error
//                else if cell.note_Status == .potentialMiddle {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedMiddle)
//                }
//                else if cell.status_Before_I_Became_The_Cursor == .potentialEnd {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedEnd)
//                }
//                currCell.note_Status = .cursor_Active_Prohibited
//
//            }
//            else if cell != currCell {
//                if cell.note_Status == .potentialSingle {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedSingle)
//                }
//                else if cell.note_Status == .potentialStart {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedStart)
//                }
//                else if cell.note_Status == .potentialMiddle {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedMiddle)
//                }
//                else if cell.status_Before_I_Became_The_Cursor == .potentialEnd {
//                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedEnd)
//                }
//            }
//
//        }
//        current_potentialNoteCellArray.removeAll()
    }

}

class Recursive_Set_Manager {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    var parent_Note_Writer: Note_Writer?
    
    var all_The_Cells_Of_The_Locked_Line : [Cursor_Grid_Cell_Data_Store]?

    var viable_Set_Formed : Bool = false
    
    var currentViableDataCellArray : [Cursor_Grid_Cell_Data_Store] = []
    
    var currentLowestViableCell_X_Index : Int?
    
    var currentHighestViableCell_X_Index : Int?
    
    // TODO: parallell state changes
    func nil_Viable_Set(){
        if let parentNoteWriter = parent_Note_Writer {
            if let parentData = parentNoteWriter.parentGridData {
                if let lclCurrCell = parentData.currCellData {

                    
                    if currentViableDataCellArray.count != 0 {
                        for sell in currentViableDataCellArray {
                            if sell == lclCurrCell {
                                
                            }
                            else if sell != lclCurrCell {

                            }
                        }
                    }

                }
            }
        }
        
        currentLowestViableCell_X_Index = nil
        currentHighestViableCell_X_Index = nil

        currentViableDataCellArray.removeAll()
        all_The_Cells_Of_The_Locked_Line = nil
        if viable_Set_Formed == true { viable_Set_Formed = false }
        
    }
    
    func define_Viable_Set(x_PlaceParam:Int){

        if let lclLocked_Line_Cell_Array = all_The_Cells_Of_The_Locked_Line {
            
            if checkTheCellIsWriteable(x_PlaceParam: x_PlaceParam, line_Cell_Array_Param: lclLocked_Line_Cell_Array) == true {
                drop_X_One_AndCheckAgain(int_To_Drop: x_PlaceParam)
                raise_X_One_AndCheckAgain(int_To_Raise: x_PlaceParam)
            }

            if let lclLow = currentLowestViableCell_X_Index
                , let lclHigh = currentHighestViableCell_X_Index {
                for x in lclLow...lclHigh {
                    currentViableDataCellArray.append(lclLocked_Line_Cell_Array[x])
                }
            }

            if currentViableDataCellArray.count > 0 {
                if viable_Set_Formed == false { viable_Set_Formed = true }
                color_Viable_Set() 
            }
            
        }
    }
    
    func color_Viable_Set() {
        if let lclParentNoteWriter = parent_Note_Writer {
            if let lclParentGridData = lclParentNoteWriter.parentGridData {
                if let lclCurrCell = lclParentGridData.currCellData {
                    for cell in currentViableDataCellArray {
                        if cell == lclCurrCell {
                            cell.processSelectabilityUpdate(isCurrentSelectedPosition: true, selectabilityUpdateParam: .in_A_Write_Viable_Group)
                        }
                        else if cell != lclCurrCell {
                            cell.processSelectabilityUpdate(isCurrentSelectedPosition: false, selectabilityUpdateParam: .in_A_Write_Viable_Group)
                        }
                    }
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
