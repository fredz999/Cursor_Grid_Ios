//
//  Note_Writer.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 09/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Potential_Note_Manager{
    
    var parentGridData : Cursor_Grid_Data_Store?
    
    var viable_Set_Manager : Viable_Set_Manager   //= Recursive_Set_Manager()
    
    var current_potentialNoteCellArray : [Cursor_Grid_Cell_Data_Store] = []{
        didSet{
            setStatus_Of_Member_Cells()
        }
    }
    
    init(){
        viable_Set_Manager = Viable_Set_Manager()
        //setupChildren()
    }
    
//    func setupChildren(){
//        viable_Set_Manager.parent_Note_Writer = self
//    }
    
    func consider_Cell_For_Addition(viable_Array_Index: Int){
        
        if viable_Set_Manager.viable_Set_Formed, let lclStartIndex = viable_Set_Manager.starter_Cell_Index {
            
            current_potentialNoteCellArray.removeAll()
            
            if lclStartIndex == viable_Array_Index {
                current_potentialNoteCellArray.append(viable_Set_Manager.currentViableDataCellArray[lclStartIndex])
                setStatus_Of_Member_Cells()
            }
            
            else if lclStartIndex < viable_Array_Index {
                for x in lclStartIndex...viable_Array_Index {
                    current_potentialNoteCellArray.append(viable_Set_Manager.currentViableDataCellArray[x])
                }
                setStatus_Of_Member_Cells()
            }

            else if lclStartIndex > viable_Array_Index {
                for x in viable_Array_Index...lclStartIndex {
                    current_potentialNoteCellArray.append(viable_Set_Manager.currentViableDataCellArray[x])
                }
                setStatus_Of_Member_Cells()
            }
            
        }
    }
    
    func setStatus_Of_Member_Cells(){
        
        for cell in viable_Set_Manager.currentViableDataCellArray {
            cell.current_BackGround_Color = .orange
        }
        //===================================================================
        //===================================================================
        if current_potentialNoteCellArray.count == 1 {
            current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialSingle)
        }
        else if current_potentialNoteCellArray.count == 2 {
            current_potentialNoteCellArray[0].current_BackGround_Color = .black
            current_potentialNoteCellArray[1].current_BackGround_Color = .white
        }
        else if current_potentialNoteCellArray.count > 2 {
            let finalIndex = current_potentialNoteCellArray.count - 1
            let penultimateIndex = current_potentialNoteCellArray.count - 2
            current_potentialNoteCellArray[0].current_BackGround_Color = .black
            for x in 1...(penultimateIndex){
                current_potentialNoteCellArray[x].current_BackGround_Color = .gray
            }
            current_potentialNoteCellArray[finalIndex].current_BackGround_Color = .white
        }
        
    }
    
    func react_To_Write_Off(){
        //recursive_Set_Manager.nil_Viable_Set()
    }
    
    func react_To_Write_On(){
        if let lclParentData = parentGridData {
            
            // 1 get the viable set
            // 2 get currentCursorNum
            // 3 establish that currentCursorNum is within boundaries of viable set
            // 4 from viable set get currLeftMost and currRightMost
            
            if lclParentData.recursive_Set_Manager.currentViableDataCellArray.count > 0 {
                
            }
            
            if let lclCurrCell = lclParentData.cursorUpdateManager.current_Cursor_Cell
            {
                
            }
            
        }
    }
    
    
//    for cell in current_potentialNoteCellArray {
//        cell.current_BackGround_Color = .green
//    }
    
//    for cell in recursive_Set_Manager.currentViableDataCellArray {
//        cell.current_BackGround_Color = .orange
//    }
//
//    for cell in current_potentialNoteCellArray {
//        cell.current_BackGround_Color = .red
//    }
    
    
//    func setStatus_Of_Member_Cells(){
//
//        if current_potentialNoteCellArray.count == 1 {
//            current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//            current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialSingle)
//        }
//        else if current_potentialNoteCellArray.count == 2{
//            let xNumStart = current_potentialNoteCellArray[0].xNumber
//            let xNumEnd = current_potentialNoteCellArray[1].xNumber
//
//            if xNumStart < xNumEnd {
//
//                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialStart)
//
//                current_potentialNoteCellArray[1].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                current_potentialNoteCellArray[1].processStatusUpdate(statusUpdateParam: .potentialEnd)
//            }
//            else if xNumStart > xNumEnd {
//
//                current_potentialNoteCellArray[1].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                current_potentialNoteCellArray[1].processStatusUpdate(statusUpdateParam: .potentialStart)
//
//                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialEnd)
//            }
//
//
//        }
//
//        else if current_potentialNoteCellArray.count > 2 {
//              let finalIndex = current_potentialNoteCellArray.count-1
//              let xNumStart = current_potentialNoteCellArray[0].xNumber
//              let xNumEnd = current_potentialNoteCellArray[finalIndex].xNumber
//              if xNumStart < xNumEnd{
//
//                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialStart)
//                for i in 1..<finalIndex{
//
//                    current_potentialNoteCellArray[i].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                    current_potentialNoteCellArray[i].processStatusUpdate(statusUpdateParam: .potentialMiddle)
//                }
//
//                  current_potentialNoteCellArray[finalIndex].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                  current_potentialNoteCellArray[finalIndex].processStatusUpdate(statusUpdateParam: .potentialEnd)
//            }
//            if xNumStart > xNumEnd{
//
//                current_potentialNoteCellArray[finalIndex].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                current_potentialNoteCellArray[finalIndex].processStatusUpdate(statusUpdateParam: .potentialStart)
//                for i in 1..<finalIndex{
//
//                    current_potentialNoteCellArray[i].processCursorStatusUpdate(isCurrentSelectedPositionParam: false)
//                    current_potentialNoteCellArray[i].processStatusUpdate(statusUpdateParam: .potentialMiddle)
//                }
//
//                current_potentialNoteCellArray[0].processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
//                current_potentialNoteCellArray[0].processStatusUpdate(statusUpdateParam: .potentialEnd)
//            }
//
//        }
//    }
    

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
////                // TODO: Check if this is in error
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
