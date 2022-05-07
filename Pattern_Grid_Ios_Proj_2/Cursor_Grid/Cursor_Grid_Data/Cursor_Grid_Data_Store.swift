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
    
    var currCellData : Cursor_Grid_Cell_Data_Store {
        willSet {
            //if currCellData.grid_Cell_Data_Note_Status == .cursor {
                if let lclPre = currCellData.status_Before_I_Became_The_Cursor {
//                    currCellData.changeStatus(newStatus: lclPre)
//                    currCellData.status_Before_I_Became_The_Cursor = nil
                    // TODO: Status Update
                    //print("willset called on X: ",current_Cursor_X_Int,", Y: ",current_Cursor_Y_Int,", pre: ", lclPre)
                    currCellData.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: lclPre)
                    
                }
            //}
        }
    }
    
    var current_Cursor_Y_Int : Int = 0
    
    var current_Cursor_X_Int : Int = 0
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    let lclColors = ComponentColors.StaticComponentColors
    
    var cell_Line_Array : [Cursor_Grid_Line_Data_Store] = []
    
    init(){
        for y in 0..<lclDimensions.returnGridVerticalEnd(){
            let line_Data = Cursor_Grid_Line_Data_Store(lineNumberParam: y)
            cell_Line_Array.append(line_Data)
        }
        
        currCellData = cell_Line_Array[0].return_Inverse_Cell(x_Param: 0)
        //currCellData.changeStatus(newStatus: .cursor_Writable)
    }
    
    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int){
        if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= cell_Line_Array.count {
            if new_Cursor_Y_Int != current_Cursor_Y_Int {
                
                current_Cursor_Y_Int = new_Cursor_Y_Int
                currCellData = cell_Line_Array[new_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)
                //currCellData.changeStatus(newStatus: .cursor_Writable)
                // TODO: Status Update
                
                if noteWritingActivated == true {
                    note_UpDate_Handler()
                }
                else if noteWritingActivated == false {
                    currCellData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: nil) //processStatusUpdate
                }

            }
        }
    }
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
        if new_Cursor_X_Int >= 0, new_Cursor_X_Int <  lclDimensions.numberCellsGridHorizontal {
            if new_Cursor_X_Int != current_Cursor_X_Int {

                current_Cursor_X_Int = new_Cursor_X_Int
                currCellData = cell_Line_Array[current_Cursor_Y_Int].return_Inverse_Cell(x_Param: new_Cursor_X_Int)
                //currCellData.changeStatus(newStatus: .cursor_Writable)
                // TODO: Status Update

                if noteWritingActivated == true {
                    note_UpDate_Handler()
                }
                else if noteWritingActivated == false {
                    currCellData.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: nil)
                }
                                
            }
        }
    }
    
    var noteWritingActivated : Bool = false {
        didSet {
            if noteWritingActivated == true{note_UpDate_Handler()}
        }
    }
    
    func note_UpDate_Handler(){
        if currCellData.grid_Cell_Data_Note_Status != .cursor_Prohibited {
            note_Cell_Accumulator.add_Note(cell: currCellData)
        }
    }
    
    var note_Cell_Accumulator : Note_Cell_Accumulator = Note_Cell_Accumulator()
    
}

class Note_Cell_Accumulator {
    
    var current_potentialNoteCellArray : [Cursor_Grid_Cell_Data_Store] = []
    
    func add_Note(cell:Cursor_Grid_Cell_Data_Store){
        current_potentialNoteCellArray.append(cell)
        setStatus_Of_Member_Cells()
    }
    
    // TODO: Status Update
    func setStatus_Of_Member_Cells(){
        if current_potentialNoteCellArray.count == 1{
            current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialSingle)
        }
        else if current_potentialNoteCellArray.count == 2{
            current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialStart)
            current_potentialNoteCellArray[1].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialEnd)
        }
        else if current_potentialNoteCellArray.count > 2{
              let finalIndex = current_potentialNoteCellArray.count-1
              current_potentialNoteCellArray[0].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialStart)
              for i in 1..<finalIndex{
              current_potentialNoteCellArray[i].processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .potentialMiddle)
              }
              current_potentialNoteCellArray[finalIndex].processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .potentialEnd)
        }
    }
    // TODO: Status Update
    func disengage(){
        
        for cell in current_potentialNoteCellArray {

            if cell.grid_Cell_Data_Note_Status == .potentialSingle {
                cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedSingle)
            }
            else if cell.grid_Cell_Data_Note_Status == .potentialStart {
                cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedStart)
            }
            else if cell.grid_Cell_Data_Note_Status == .potentialMiddle {
                cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedMiddle)
            }
            else if cell.status_Before_I_Became_The_Cursor == .potentialEnd {
                cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedEnd)
            }
        }
        
        current_potentialNoteCellArray.removeAll()
    }
}
