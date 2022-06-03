//
//  Recursive_Set_Manager.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 14/05/2022.
//

import Foundation
import SwiftUI
import Combine


class Viable_Set_Manager {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    var all_The_Cells_Of_The_Locked_Line : [Cursor_Grid_Cell_Data_Store]?

    var viable_Set_Formed : Bool = false
    
    var currentViableDataCellArray : [Cursor_Grid_Cell_Data_Store] = []
    
    var currentLowestViableCell_X_Index : Int?
    
    var currentHighestViableCell_X_Index : Int?
    
    //var intial_In_Line_Cursor_X : Int?
    
    var starterCells_Position_In_Viable_Array : Int?
    
    var lineCellsOptional : [Cursor_Grid_Cell_Data_Store]?

    var lowestViableMembers_XNum : Int?
    
    func nil_Viable_Set(){
        if lowestViableMembers_XNum != nil{lowestViableMembers_XNum=nil}
        //if intial_In_Line_Cursor_X != nil{intial_In_Line_Cursor_X = nil}
        for cell in currentViableDataCellArray{
            cell.place_In_Viable_Set = nil
        }
        lineCellsOptional = nil
        currentLowestViableCell_X_Index = nil
        currentHighestViableCell_X_Index = nil
        if currentViableDataCellArray.count > 0 {
            for cell in currentViableDataCellArray {
                cell.viable_Group_Status = .not_In_A_Write_Viable_Group
                cell.repaint_Cell()
            }
        }
        currentViableDataCellArray.removeAll()
        all_The_Cells_Of_The_Locked_Line = nil
        if viable_Set_Formed == true { viable_Set_Formed = false }
    }

    func define_Viable_Set(cellParam:Cursor_Grid_Cell_Data_Store,callback : ()->()) {
//        if intial_In_Line_Cursor_X == nil{
//            intial_In_Line_Cursor_X=cellParam.xNumber
//        }

        if let cellsParentLine = cellParam.parentDataLine, viable_Set_Formed == false {
            
            lineCellsOptional = cellsParentLine.cell_Data_Array
            
            if checkTheCellIsWriteable(x_PlaceParam: cellParam.xNumber, line_Cell_Array_Param: cellsParentLine.cell_Data_Array) == true {
                drop_X_One_AndCheckAgain(int_To_Drop: cellParam.xNumber)
                raise_X_One_AndCheckAgain(int_To_Raise: cellParam.xNumber)
            }
            
            if let lclLow = currentLowestViableCell_X_Index
                , let lclHigh = currentHighestViableCell_X_Index {

                lowestViableMembers_XNum = lclLow
                
                for x in lclLow...lclHigh {
                    if x < lclHigh {
                        currentViableDataCellArray.append(cellsParentLine.cell_Data_Array[x])
                        if x == cellParam.xNumber {starterCells_Position_In_Viable_Array = currentViableDataCellArray.count-1}
                    }
                    else if x == lclHigh {
                        currentViableDataCellArray.append(cellsParentLine.cell_Data_Array[x])
                        if x == cellParam.xNumber {starterCells_Position_In_Viable_Array = currentViableDataCellArray.count-1}
                        viable_Set_Formed = true
                        callback()
                    }
                }
                
            }
        }
    }
    
    func checkTheCellIsWriteable(x_PlaceParam:Int,line_Cell_Array_Param : [Cursor_Grid_Cell_Data_Store])->Bool{
        var retval = false
        if line_Cell_Array_Param[x_PlaceParam].note_Status == .unassigned{
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
    
    func check_Lower_Termination_Criteria(valueToCheck: Int) {
        
        if let lclLine = lineCellsOptional{
            if lclLine[valueToCheck].note_Status != .unassigned {
                if currentLowestViableCell_X_Index == nil {
                    currentLowestViableCell_X_Index = valueToCheck+1
                }
            }
            else if lclLine[valueToCheck].note_Status == .unassigned {
                drop_X_One_AndCheckAgain(int_To_Drop: (valueToCheck))
            }
        }
    }

    func check_Higher_Termination_Criteria(valueToCheck: Int) {
        if let lclLine = lineCellsOptional{
            if lclLine[valueToCheck].note_Status != .unassigned {
                if currentHighestViableCell_X_Index == nil {
                    currentHighestViableCell_X_Index = valueToCheck-1
                }
            }
            else if lclLine[valueToCheck].note_Status == .unassigned {
                raise_X_One_AndCheckAgain(int_To_Raise: (valueToCheck))
            }
        }
    }
    
    
    
    
    
}
