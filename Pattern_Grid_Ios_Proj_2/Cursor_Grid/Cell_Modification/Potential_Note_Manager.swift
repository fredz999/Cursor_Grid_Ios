//
//  Note_Writer.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 09/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Potential_Note_Manager {
    
    // poss protocol here? (the parent data is in other managers)
    var parent_Grid_Data : Cursor_Grid_Data_Store?
    
    var current_potentialNoteCellArray : [Cursor_Grid_Cell_Data_Store] = []
    
    var potentialStartIndex : Int?
    
    var currentEndIndex : Int?
    
    var currently_Has_Potential_Note : Bool?
    
    func set_Status_Of_Member_Cells(){
        
        if current_potentialNoteCellArray.count == 1 {
            //current_potentialNoteCellArray[0].current_BackGround_Color = .black
            // TODO: tis potentialSingle
            current_potentialNoteCellArray[0].note_Status = .potentialSingle
            //current_potentialNoteCellArray[0].handle_StatusChange()
        }
        else if current_potentialNoteCellArray.count == 2 {
            current_potentialNoteCellArray[0].note_Status = .potentialStart
            //current_potentialNoteCellArray[0].handle_StatusChange()
            current_potentialNoteCellArray[1].note_Status = .potentialEnd
            //current_potentialNoteCellArray[1].handle_StatusChange()
        }
        else if current_potentialNoteCellArray.count > 2 {
            let finalIndex = current_potentialNoteCellArray.count - 1
            let penultimateIndex = current_potentialNoteCellArray.count - 2
            current_potentialNoteCellArray[0].note_Status = .potentialStart
            //current_potentialNoteCellArray[0].handle_StatusChange()
            for x in 1...(penultimateIndex){
                current_potentialNoteCellArray[x].note_Status = .potentialMiddle
                //current_potentialNoteCellArray[x].handle_StatusChange()
            }
            current_potentialNoteCellArray[finalIndex].note_Status = .potentialEnd
            //current_potentialNoteCellArray[finalIndex].handle_StatusChange()
        }
    }

    // TODO: note write
    func set_PotentialNote_StartIndex(indexParam : Int){
        potentialStartIndex = indexParam
    }
    
    func set_PotentialNote_EndIndex(indexParam : Int){
        currentEndIndex = indexParam
        rePopulatePotentialArray()
    }
    
    private func rePopulatePotentialArray(){
        if let lcl_Start = potentialStartIndex, let lcl_End = currentEndIndex {
            if let lclParentData = parent_Grid_Data {

                current_potentialNoteCellArray.removeAll()
                
                if lcl_End > lcl_Start {
                    for x in lcl_Start...lcl_End {
                        current_potentialNoteCellArray.append(lclParentData.viable_Set_Manager.currentViableDataCellArray[x])
                    }
                }
                else if lcl_End < lcl_Start {
                    for x in lcl_End...lcl_Start {
                        current_potentialNoteCellArray.append(lclParentData.viable_Set_Manager.currentViableDataCellArray[x])
                    }
                }
                else if lcl_End == lcl_Start {
                    current_potentialNoteCellArray.append(lclParentData.viable_Set_Manager.currentViableDataCellArray[lcl_Start])
                }
                
            }
            if current_potentialNoteCellArray.count > 0 {
                currently_Has_Potential_Note = true
            }
        }
        set_Status_Of_Member_Cells()
    }
    
    func nilPotentialArray(){
    potentialStartIndex = nil
    currentEndIndex = nil
    current_potentialNoteCellArray.removeAll()
    currently_Has_Potential_Note = false
    }
    
    func commit_Note(){
        // TODO: note commit
        for cell in current_potentialNoteCellArray {
            if cell.note_Status == .potentialSingle {
                cell.note_Status = .confirmedSingle
            }
            else if cell.note_Status == .potentialStart {
                cell.note_Status = .confirmedStart
            }
            else if cell.note_Status == .potentialMiddle {
                cell.note_Status = .confirmedMiddle
            }
            else if cell.note_Status == .potentialEnd {
                cell.note_Status = .confirmedEnd
            }
            else{
                print("something else happened")
            }
        }
        
    }

}



//class Note_Writer {
//
//    var parentGridData : Cursor_Grid_Data_Store?
//
//    var viable_Set_Manager : Viable_Set_Manager   //= Recursive_Set_Manager()
//
//    var current_potentialNoteCellArray : [Cursor_Grid_Cell_Data_Store] = []{
//        didSet{
//            setStatus_Of_Member_Cells()
//        }
//    }
//
//    init(){
//        viable_Set_Manager = Viable_Set_Manager()
//        setupChildren()
//    }
//
//    func setupChildren(){
//        viable_Set_Manager.parent_Note_Writer = self
//    }
//
//    func consider_Cell_For_Addition(viable_Array_Index: Int){
//
//        if viable_Set_Manager.viable_Set_Formed, let lclStartIndex = viable_Set_Manager.starter_Cell_Index {
//
//            current_potentialNoteCellArray.removeAll()
//
//            if lclStartIndex == viable_Array_Index {
//                current_potentialNoteCellArray.append(viable_Set_Manager.currentViableDataCellArray[lclStartIndex])
//                setStatus_Of_Member_Cells()
//            }
//
//            else if lclStartIndex < viable_Array_Index {
//                for x in lclStartIndex...viable_Array_Index {
//                    current_potentialNoteCellArray.append(viable_Set_Manager.currentViableDataCellArray[x])
//                }
//                setStatus_Of_Member_Cells()
//            }
//
//            else if lclStartIndex > viable_Array_Index {
//                for x in viable_Array_Index...lclStartIndex {
//                    current_potentialNoteCellArray.append(viable_Set_Manager.currentViableDataCellArray[x])
//                }
//                setStatus_Of_Member_Cells()
//            }
//
//        }
//    }
//
//    func setStatus_Of_Member_Cells(){
//
//        for cell in viable_Set_Manager.currentViableDataCellArray {
//            cell.current_BackGround_Color = .orange
//        }
//        //===================================================================
//        //===================================================================
//        if current_potentialNoteCellArray.count == 1 {
//            current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialSingle)
//        }
//        else if current_potentialNoteCellArray.count == 2 {
//            current_potentialNoteCellArray[0].current_BackGround_Color = .black
//            current_potentialNoteCellArray[1].current_BackGround_Color = .white
//        }
//        else if current_potentialNoteCellArray.count > 2 {
//            let finalIndex = current_potentialNoteCellArray.count - 1
//            let penultimateIndex = current_potentialNoteCellArray.count - 2
//            current_potentialNoteCellArray[0].current_BackGround_Color = .black
//            for x in 1...(penultimateIndex){
//                current_potentialNoteCellArray[x].current_BackGround_Color = .gray
//            }
//            current_potentialNoteCellArray[finalIndex].current_BackGround_Color = .white
//        }
//
//    }
//
//    func react_To_Write_Off(){
//        //recursive_Set_Manager.nil_Viable_Set()
//    }
//
//    func react_To_Write_On(){
////        if let lclParentData = parentGridData {
////            if let lclCurrCell = lclParentData.cursorUpdateManager.current_Cursor_Cell
////            {
////                recursive_Set_Manager.define_Viable_Set(cellParam: lclCurrCell)
////            }
////        }
//    }
//
//
////    for cell in current_potentialNoteCellArray {
////        cell.current_BackGround_Color = .green
////    }
//
////    for cell in recursive_Set_Manager.currentViableDataCellArray {
////        cell.current_BackGround_Color = .orange
////    }
////
////    for cell in current_potentialNoteCellArray {
////        cell.current_BackGround_Color = .red
////    }
//
//
////    func setStatus_Of_Member_Cells(){
////
////        if current_potentialNoteCellArray.count == 1 {
////            current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
////            current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialSingle)
////        }
////        else if current_potentialNoteCellArray.count == 2{
////            let xNumStart = current_potentialNoteCellArray[0].xNumber
////            let xNumEnd = current_potentialNoteCellArray[1].xNumber
////
////            if xNumStart < xNumEnd {
////
////                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
////                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialStart)
////
////                current_potentialNoteCellArray[1].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
////                current_potentialNoteCellArray[1].processStatusUpdate(statusUpdateParam: .potentialEnd)
////            }
////            else if xNumStart > xNumEnd {
////
////                current_potentialNoteCellArray[1].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
////                current_potentialNoteCellArray[1].processStatusUpdate(statusUpdateParam: .potentialStart)
////
////                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
////                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialEnd)
////            }
////
////
////        }
////
////        else if current_potentialNoteCellArray.count > 2 {
////              let finalIndex = current_potentialNoteCellArray.count-1
////              let xNumStart = current_potentialNoteCellArray[0].xNumber
////              let xNumEnd = current_potentialNoteCellArray[finalIndex].xNumber
////              if xNumStart < xNumEnd{
////
////                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
////                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialStart)
////                for i in 1..<finalIndex{
////
////                    current_potentialNoteCellArray[i].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
////                    current_potentialNoteCellArray[i].processStatusUpdate(statusUpdateParam: .potentialMiddle)
////                }
////
////                  current_potentialNoteCellArray[finalIndex].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
////                  current_potentialNoteCellArray[finalIndex].processStatusUpdate(statusUpdateParam: .potentialEnd)
////            }
////            if xNumStart > xNumEnd{
////
////                current_potentialNoteCellArray[finalIndex].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
////                current_potentialNoteCellArray[finalIndex].processStatusUpdate(statusUpdateParam: .potentialStart)
////                for i in 1..<finalIndex{
////
////                    current_potentialNoteCellArray[i].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
////                    current_potentialNoteCellArray[i].processStatusUpdate(statusUpdateParam: .potentialMiddle)
////                }
////
////                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
////                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialEnd)
////            }
////
////        }
////    }
//
//
//    func commit_Note(currCell:Cursor_Grid_Cell_Data_Store){
//
////        for cell in current_potentialNoteCellArray {
////
////            if cell == currCell {
////                if cell.note_Status == .potentialSingle {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedSingle)
////                }
////                else if cell.note_Status == .potentialStart {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedStart)
////                }

////                else if cell.note_Status == .potentialMiddle {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedMiddle)
////                }
////                else if cell.status_Before_I_Became_The_Cursor == .potentialEnd {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: true, statusUpdateParam: .confirmedEnd)
////                }
////                currCell.note_Status = .cursor_Active_Prohibited
////
////            }
////            else if cell != currCell {
////                if cell.note_Status == .potentialSingle {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedSingle)
////                }
////                else if cell.note_Status == .potentialStart {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedStart)
////                }
////                else if cell.note_Status == .potentialMiddle {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedMiddle)
////                }
////                else if cell.status_Before_I_Became_The_Cursor == .potentialEnd {
////                    cell.processStatusUpdate(isCurrentSelectedPosition: false, statusUpdateParam: .confirmedEnd)
////                }
////            }
////
////        }
////        current_potentialNoteCellArray.removeAll()
//    }
//
//}
