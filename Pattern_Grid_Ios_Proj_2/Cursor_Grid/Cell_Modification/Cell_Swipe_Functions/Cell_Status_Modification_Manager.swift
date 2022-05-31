//
//  Cell_Modification_Manager.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 26/05/2022.
//

import Foundation
import SwiftUI
import Combine
class Cell_Status_Modification_Manager {
    
    // the idea here is to make it so that modifications can be carried out against cells
    // possibly numerous modifications to numerous cells and only after they have
    // been fully modified do they then undergo visual updates
    // 1: cursor modificstion
    
    var currCursorX_Int : Int
    var currCursorY_Int : Int
    
    var parentDataGrid : Cursor_Grid_Data_Store?
    
    var viableSetManager = Viable_Set_Manager()
    var viable_Group_Cursor_X_Current : Int?
    var viable_Group_Cursor_X_Previous : Int?
    var starter_Cells_Index_In_ViableGroup : Int?
    
    var rightwardNote_Expand_Functions : RightwardNote_Expand_Rightward_Functions?
    var rightwardNote_Contract_Functions : RightwardNote_Contract_Leftward_Functions?
    var cell_Rightward_Setting_Functions : Cell_Rightward_Setting_Functions?
    
    
    var leftwardNote_Expand_Leftward_Functions : LeftwardNote_Expand_Leftward_Functions?
    var leftwardNote_Contract_Leftward_Functions : LeftwardNote_Contract_Leftward_Functions?
    var cell_Leftward_Setting_Functions : Cell_Leftward_Setting_Functions?
    
    
    init(startCursorX:Int,startCursorY:Int){
    currCursorX_Int = startCursorX
    currCursorY_Int = startCursorY
    setChildren()
    }
    
    func setChildren(){
        rightwardNote_Expand_Functions = RightwardNote_Expand_Rightward_Functions(viableSetManagerParam: viableSetManager, parentParam: self)
        rightwardNote_Contract_Functions =  RightwardNote_Contract_Leftward_Functions(viableSetManagerParam: viableSetManager, parentParam: self)
        cell_Rightward_Setting_Functions = Cell_Rightward_Setting_Functions(parentParam: self)
        
        leftwardNote_Expand_Leftward_Functions = LeftwardNote_Expand_Leftward_Functions(viableSetManagerParam: viableSetManager, parentParam: self)
        leftwardNote_Contract_Leftward_Functions = LeftwardNote_Contract_Leftward_Functions(viableSetManagerParam: viableSetManager, parentParam: self)
        cell_Leftward_Setting_Functions = Cell_Leftward_Setting_Functions(parentParam: self)
    }
    
    func figure_Out_Whats_To_Be_Done_With_Each_Cell_After_A_Cursor_X_Move() {
        if viableSetManager.viable_Set_Formed == true {
            starter_Cells_Index_In_ViableGroup = viableSetManager.starterCells_Position_In_Viable_Array
            if let lcl_ViableSets_LowX = viableSetManager.lowestViableMembers_XNum {
                if viable_Group_Cursor_X_Current == nil {
                    viable_Group_Cursor_X_Current = currCursorX_Int - lcl_ViableSets_LowX
                }
                else if viable_Group_Cursor_X_Current != nil {
                    viable_Group_Cursor_X_Previous = viable_Group_Cursor_X_Current
                    viable_Group_Cursor_X_Current = currCursorX_Int - lcl_ViableSets_LowX
                }
                
            }
            print_State_Updates()
        }
    }

    func print_State_Updates(){
        if viable_Group_Cursor_X_Previous == nil
        ,let startX = starter_Cells_Index_In_ViableGroup {
            initial_Viable_Set_State_Update()
        }
        else if let currX = viable_Group_Cursor_X_Current,
                let prevX = viable_Group_Cursor_X_Previous,
            let startX = starter_Cells_Index_In_ViableGroup
        {
            if currX > startX{
                if currX > prevX{
                    rightwardNote_Expanding_Rightward()
                }
                else if currX < prevX{
                    rightwardNote_Contracting_Leftward()
                }
            }
            
            else if currX < startX {
                if currX > prevX {
                    leftWardNote_Contracting_Rightward()
                }
                else if currX < prevX {
                    leftWardNote_Expanding_Leftward()
                }
            }
            
            else if currX == startX {
                if currX > prevX {
                    print("currX = startX, it contracted back into a single cell pick from the left")
                    leftWardNote_Contracting_Rightward()
                }
                else if currX < prevX {
                    rightwardNote_Contracting_Leftward()
                }
            }
            

        }
        
    }
    
    func initial_Viable_Set_State_Update(){
        // just started
            if let lclCurrent = viable_Group_Cursor_X_Current {
                for x in 0..<viableSetManager.currentViableDataCellArray.count {
                    if x == viable_Group_Cursor_X_Current {
                        var modArray = [Cell_Modification]()

                        let viabilityMembershipMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
                        viabilityMembershipMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
                        modArray.append(viabilityMembershipMod)
                        
                        let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
                        potentialNoteMod.note_Status_Modification_Value = .potentialSingle
                        modArray.append(potentialNoteMod)
                        
                        let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
                        cursorMod.cursor_Modification_Value = .is_The_Current_Cursor
                        modArray.append(cursorMod)
                        
                        apply_A_Bunch_Of_Modifications(cell: viableSetManager.currentViableDataCellArray[lclCurrent] , modificationArray: modArray)
                    }
                    else if x != viable_Group_Cursor_X_Current {
                        var modArray = [Cell_Modification]()
                        let viabilityMembershipMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
                        viabilityMembershipMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
                        modArray.append(viabilityMembershipMod)
                        apply_A_Bunch_Of_Modifications(cell: viableSetManager.currentViableDataCellArray[x] , modificationArray: modArray)
                    }
                }
            }
            for cell in viableSetManager.currentViableDataCellArray {
                cell.repaint_Cell()
            }
    }
    
    
    func leftWardNote_Expanding_Leftward(){
        if let currX = viable_Group_Cursor_X_Current
        {
            //if currX < viableSetManager.currentViableDataCellArray.count,currX>0 {
                if let lclLeft_ExpandFuncs = leftwardNote_Expand_Leftward_Functions{
                    //lclRight_ExpandFuncs.process_Rightward_Expansion(currX:currX)
                    lclLeft_ExpandFuncs.leftwardNote_Expanding_Left_Swipe(currX: currX)
                }
            //}
        }
    }
    
    func leftWardNote_Contracting_Rightward(){
        if let currX = viable_Group_Cursor_X_Current
        {
            if let lclLeft_ExpandFuncs = leftwardNote_Contract_Leftward_Functions {
                lclLeft_ExpandFuncs.leftwardNote_Contracting_Right_Swipe(currX: currX)
            }
        }
    }
    
    func rightwardNote_Expanding_Rightward(){
        if let currX = viable_Group_Cursor_X_Current
        {
            if currX < viableSetManager.currentViableDataCellArray.count,currX>0 {
                if let lclRight_ExpandFuncs = rightwardNote_Expand_Functions{
                    lclRight_ExpandFuncs.process_Rightward_Expansion(currX:currX)
                }
                
            }
        }
    }
    
    func rightwardNote_Contracting_Leftward(){
        if let currX = viable_Group_Cursor_X_Current,
           //let prevX = viable_Group_Cursor_X_Previous,
           let lclStartX = starter_Cells_Index_In_ViableGroup
        {
            if currX >= lclStartX,currX < viableSetManager.currentViableDataCellArray.count {
                if let lclRightwardNote_Contract_Functions = rightwardNote_Contract_Functions{
                    lclRightwardNote_Contract_Functions.tempArrayPaint_Contracting_Right_Swipe(currX:currX)
                }
            }
        }
    }

    func update_Cursor_X(new_Cursor_X_Int:Int) {
 
        if let lclGridData = parentDataGrid {
            if lclGridData.noteWritingActivated == false {
                let modifier_1 = Cell_Modification(typeParam: .cursor_Modification)
                modifier_1.cursor_Modification_Value = .not_The_Current_Cursor
                let modifier_2 = Cell_Modification(typeParam: .cursor_Modification)
                modifier_2.cursor_Modification_Value = .is_The_Current_Cursor
                
                let cellOld = lclGridData.returnSpecificCell(xVal: currCursorX_Int, yVal: currCursorY_Int)
                currCursorX_Int = new_Cursor_X_Int
                let cellNew = lclGridData.returnSpecificCell(xVal: currCursorX_Int, yVal: currCursorY_Int)
                apply_Single_Modification(cell: cellOld, modification: modifier_1)
                apply_Single_Modification(cell: cellNew, modification: modifier_2)
                cellOld.repaint_Cell()
                cellNew.repaint_Cell()
            }
            else if lclGridData.noteWritingActivated == true {
                currCursorX_Int = new_Cursor_X_Int
                figure_Out_Whats_To_Be_Done_With_Each_Cell_After_A_Cursor_X_Move()
            }
        }
    }
    
    func update_Cursor_Y(new_Cursor_Y_Int:Int) {
        if let lclGridData = parentDataGrid {
            if lclGridData.noteWritingActivated == false {
                lclGridData.cell_Line_Array[currCursorY_Int].cell_Data_Array[currCursorX_Int].cursor_Status = .not_The_Current_Cursor
                lclGridData.cell_Line_Array[currCursorY_Int].cell_Data_Array[currCursorX_Int].repaint_Cell()
                currCursorY_Int = new_Cursor_Y_Int
                lclGridData.cell_Line_Array[currCursorY_Int].cell_Data_Array[currCursorX_Int].cursor_Status = .is_The_Current_Cursor
                lclGridData.cell_Line_Array[currCursorY_Int].cell_Data_Array[currCursorX_Int].repaint_Cell()
            }
        }
    }
    
    func apply_Single_Modification(cell:Cursor_Grid_Cell_Data_Store,modification:Cell_Modification){
        if modification.type == .cursor_Modification, let lclNewCursorStatus = modification.cursor_Modification_Value{
            cell.cursor_Status = lclNewCursorStatus
        }
        else if modification.type == .viable_Group_Memberhip_Modification, let lclNewViableGroupStatus = modification.viable_Group_Membership_Modification_Value {
            cell.viable_Group_Status = lclNewViableGroupStatus
        }
        else if modification.type == .note_Modification, let lclNewNoteStatus = modification.note_Status_Modification_Value {
            cell.note_Status = lclNewNoteStatus
        }
    }

    func apply_A_Bunch_Of_Modifications(cell:Cursor_Grid_Cell_Data_Store,modificationArray:[Cell_Modification]) {
        for modification in modificationArray {
            if modification.type == .cursor_Modification, let lclNewCursorStatus = modification.cursor_Modification_Value {
                if cell.cursor_Status != lclNewCursorStatus{cell.cursor_Status = lclNewCursorStatus}
            }
            else if modification.type == .viable_Group_Memberhip_Modification, let lclNewViableGroupStatus = modification.viable_Group_Membership_Modification_Value {
                if cell.viable_Group_Status != lclNewViableGroupStatus{cell.viable_Group_Status = lclNewViableGroupStatus}
            }
            else if modification.type == .note_Modification, let lclNewNoteStatus = modification.note_Status_Modification_Value {
                if cell.note_Status != lclNewNoteStatus{cell.note_Status = lclNewNoteStatus}
            }
        }
    }
    
    func getCurrentViableSet_Then_Go_Thru_It() {
        if let lclParentDataGrid = parentDataGrid {
            if viableSetManager.viable_Set_Formed == false {
                let currCell = lclParentDataGrid.returnSpecificCell(xVal: currCursorX_Int, yVal: currCursorY_Int)
                viableSetManager.define_Viable_Set(cellParam: currCell, callback: figure_Out_Whats_To_Be_Done_With_Each_Cell_After_A_Cursor_X_Move)
            }
        }
    }

    func finishWithViableSetForNow(){
        if viable_Group_Cursor_X_Previous != nil{viable_Group_Cursor_X_Previous=nil}
        if viable_Group_Cursor_X_Current != nil{viable_Group_Cursor_X_Current=nil}
        if viableSetManager.currentViableDataCellArray.count > 0 {
            viableSetManager.nil_Viable_Set()
        }
    }
    
}

class Cell_Modification {
    var type : CELL_DATA_MODIFICATION_TYPE
    init(typeParam : CELL_DATA_MODIFICATION_TYPE){
        type = typeParam
    }
    var cursor_Modification_Value : Grid_Cell_Data_Cursor_Status?
    var viable_Group_Membership_Modification_Value : Grid_Cell_Data_In_Viable_Group_Status?
    var note_Status_Modification_Value : Grid_Cell_Data_Note_Status?
}


