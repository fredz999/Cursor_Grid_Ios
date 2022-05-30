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
    var rightwardNote_Expand_Functions : RightwardNote_Expand_Functions?
    var rightwardNote_Contract_Functions : RightwardNote_Contract_Functions?
    
    init(startCursorX:Int,startCursorY:Int){
        currCursorX_Int = startCursorX
        currCursorY_Int = startCursorY
        setChildren()
    }
    
    func setChildren(){
        rightwardNote_Expand_Functions = RightwardNote_Expand_Functions(viableSetManagerParam: viableSetManager
                                                                        , parentParam: self)
        rightwardNote_Contract_Functions =  RightwardNote_Contract_Functions(viableSetManagerParam: viableSetManager
                                                                             , parentParam: self)
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
        
        // 1: startX laft of endX, cursor moves right from previous position
        // 2: startX laft of endX, cursor moves left from previous position
        // 1: startX right of endX, cursor moves right from previous position
        // 2: startX right of endX, cursor moves left from previous position
        if viable_Group_Cursor_X_Previous == nil
        ,let startX = starter_Cells_Index_In_ViableGroup {
            //print("startX(in viable group) : ",startX, ", start and end x are the same")
            
//            print("startX(in viable group) : ",startX, ", start and end x are the same"
//                  ,", viableGroup Line LeftMost Index: ",viableSetManager.currentLowestViableCell_X_Index
//                  ,", viableGroup Line RightMost Index: ",viableSetManager.currentHighestViableCell_X_Index)
            
            initial_Viable_Set_State_Update()
            
        }
        else if let currX = viable_Group_Cursor_X_Current,
                let prevX = viable_Group_Cursor_X_Previous,
            let startX = starter_Cells_Index_In_ViableGroup
        {
            if currX > startX{
                if currX > prevX{
                    //print("currX > startX, currX moved right from prevX")
                    // this means the note is expanding rightward..... will change the func name now
                    rightwardNote_Expanding_Rightward()
                }
                else if currX < prevX{
                    //print("currX > startX, currX moved left from prevX")
                    
//                    if let lclRightWardNoteContractFuncs = rightwardNote_Contract_Functions{
//                        lclRightWardNoteContractFuncs.rightwardNote_Contracting_Leftward()
//                    }
                    rightwardNote_Contracting_Leftward()
                }
            }
            
            else if currX < startX {
                if currX > prevX{
                    print("currX < startX, currX moved right from prevX")
                }
                else if currX < prevX {
                    print("currX < startX, currX moved left from prevX")
                }
            }
            
            else if currX == startX {
                if currX > prevX {
                    print("currX = startX, currX moved right from prevX")
                }
                //went all the way inward from the right
                else if currX < prevX {
                    //print("currX = startX, currX moved left from prevX")
                    // because it came from a leftward contraction
//                    if let lclRightWardNoteContractFuncs = rightwardNote_Contract_Functions{
//                        lclRightWardNoteContractFuncs.rightwardNote_Contracting_Leftward()
//                    }
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


class RightwardNote_Expand_Functions{
    
    var viableSetManager : Viable_Set_Manager
    
    var parent : Cell_Status_Modification_Manager
    
    init(viableSetManagerParam:Viable_Set_Manager,parentParam : Cell_Status_Modification_Manager){
        viableSetManager = viableSetManagerParam
        parent = parentParam
    }
    
    func process_Rightward_Expansion(currX:Int){
        //print("tempArrayPaint_Right_Swipe, startX: ",startX,", currX: ",currX)
        if let lclStartX = parent.starter_Cells_Index_In_ViableGroup {
            var paintLineArray = [Cursor_Grid_Cell_Data_Store]()
            // for it to be set to start(on rightward swipe)
            // it must not be already: 1: in the viable,2:potentialStart,3: noteTheCursor -- if its already all three of those things
            // it does not require processing
            
            
            if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
            {
                setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
            }
            
            
            
            // for it to be set to mid(on rightward swipe)
            // it must not be already: 1: in the viable,2:potentialMid,3: noteTheCursor -- if its already all three of those things
            // it does not require processing
            if currX > lclStartX+1 {
                for x in lclStartX+1..<currX {
                    //setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                    if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[x].note_Status != .potentialMiddle
                        || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                    {
                        setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                    }
                }
            }
            // for it to be set to end(on rightward swipe)
            // it must not be already: 1: in the viable,2:potentialEnd,3: Is_The_Cursor -- if its already all three of those things
            // it does not require processing
            
            if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialEnd
                || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .is_The_Current_Cursor
            {
                setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
            }
            
            
            if viableSetManager.currentViableDataCellArray.count > currX+1 {
                //make sure all the outside notes are simply set to viable / not painted
                //for it to be set to merely in viable array(on rightward swipe)
                //it must not already be 1: note: .unassigned, 3: notCursor, 3: .in_A_Viable_Set -- if its already all three of those things
                // it does not require processing
                for x in currX+1..<viableSetManager.currentViableDataCellArray.count {
                    if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[x].note_Status != .unassigned
                        || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                    {
                        set_Cell_To_Viable_Unassigned(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                    }
                    //viableSetManager.currentViableDataCellArray[x].current_BackGround_Color = Color(red: 0, green: 1, blue: 1)
                }
            }
            for cell in paintLineArray{
                cell.repaint_Cell()
            }
        }
    }
    
    func setCellToStartNote(cell: Cursor_Grid_Cell_Data_Store,isToBeACursor:Bool,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group{
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialStart{
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .potentialStart
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .is_The_Current_Cursor{
            if isToBeACursor == false {
                let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
                cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
                modArray.append(cursorMod)
                if markedForPainting == false{markedForPainting = true}
            }
        }
        else if cell.cursor_Status == .not_The_Current_Cursor{
            if isToBeACursor == true {
                let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
                cursorMod.cursor_Modification_Value = .is_The_Current_Cursor
                modArray.append(cursorMod)
                if markedForPainting == false{markedForPainting = true}
            }
        }
        if modArray.count > 0{
   
                parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
       
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
    }
    
    func setCellsToMidNote(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        // viabilityStatus must be in viable group
        // noteStatus must be .potentialMid
        // cursorStatus must be .not_The_Current_Cursor
        // think I'll run checks in the caller - if its all three things that its supposed to be then I'll leave it
        
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group{
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialMiddle{
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .potentialMiddle
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .is_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
            modArray.append(cursorMod)
            if markedForPainting == false{markedForPainting = true}
        }
 
        if modArray.count > 0 {
//            if let lclParent = parentCell_Status_Modification_Manager{
//                lclParent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
//            }
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
        
        
    }
    
    func setCellToEndNote(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        // viabilityStatus must be in viable group
        // noteStatus must be .potentialEnd
        // cursorStatus must be .is_Current_Cursor
        // think I'll run checks in the caller - if its all three things that its supposed to be then I'll leave it
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group {
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialEnd {
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .potentialEnd
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .not_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .is_The_Current_Cursor
            modArray.append(cursorMod)
            if markedForPainting == false{markedForPainting = true}
        }
 
        if modArray.count > 0{
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
        
        
    }
    
    func set_Cell_To_Viable_Unassigned(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        
        if cell.viable_Group_Status != .in_A_Write_Viable_Group {
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .unassigned {
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .unassigned
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .is_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
            modArray.append(cursorMod)
            if markedForPainting == false{markedForPainting = true}
        }
 
        if modArray.count > 0 {
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
    }
}

class RightwardNote_Contract_Functions{
    
    var viableSetManager : Viable_Set_Manager
    
    var parent : Cell_Status_Modification_Manager
    
    init(viableSetManagerParam:Viable_Set_Manager,parentParam : Cell_Status_Modification_Manager){
        viableSetManager = viableSetManagerParam
        parent = parentParam
    }
    
    func tempArrayPaint_Contracting_Right_Swipe(currX:Int){
        var paintLineArray = [Cursor_Grid_Cell_Data_Store]()
        if let lclStartX = parent.starter_Cells_Index_In_ViableGroup {
            
                if lclStartX < currX-1{
                    if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                        || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                    {
                        setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
                    }
                    
                    for x in lclStartX+1..<currX {
                        if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                            || viableSetManager.currentViableDataCellArray[x].note_Status != .potentialMiddle
                            || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                        {
                            setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }
                    
                    if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialEnd
                        || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .is_The_Current_Cursor
                    {
                        setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                    }
                    
                }
                else if lclStartX == currX-1{
                    if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                        || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                    {
                        setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
                    }

                    if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialEnd
                        || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .is_The_Current_Cursor
                    {
                        setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                    }
                }
            
                else if lclStartX == currX{
                    if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                        || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status == .not_The_Current_Cursor
                    {
                        setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: true, paintLineArray: &paintLineArray)
                    }
                }
                
                if viableSetManager.currentViableDataCellArray.count > currX+1 {
                    for x in currX+1..<viableSetManager.currentViableDataCellArray.count {
                        if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                            || viableSetManager.currentViableDataCellArray[x].note_Status != .unassigned
                            || viableSetManager.currentViableDataCellArray[x].cursor_Status == .is_The_Current_Cursor
                        {
                            set_Cell_To_Viable_Unassigned(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }
                }
            for cell in paintLineArray{
                cell.repaint_Cell()
            }
                //===============================================================================================================
            
            
                
            }
        }
    
    
    func setCellToStartNote(cell: Cursor_Grid_Cell_Data_Store,isToBeACursor: Bool,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group{
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialStart{
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .potentialStart
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .not_The_Current_Cursor{
            if isToBeACursor == true {
                let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
                cursorMod.cursor_Modification_Value = .is_The_Current_Cursor
                modArray.append(cursorMod)
                if markedForPainting == false{markedForPainting = true}
                print("set start to cursor?")
            }
        }
        else if cell.cursor_Status == .is_The_Current_Cursor {
            if isToBeACursor == false {
                let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
                cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
                modArray.append(cursorMod)
                if markedForPainting == false{markedForPainting = true}
                print("set start to cursor?")
            }
        }
        if modArray.count > 0{
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
    }
    
    func setCellsToMidNote(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        // viabilityStatus must be in viable group
        // noteStatus must be .potentialMid
        // cursorStatus must be .not_The_Current_Cursor
        // think I'll run checks in the caller - if its all three things that its supposed to be then I'll leave it
        
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group{
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialMiddle{
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .potentialMiddle
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .is_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
            modArray.append(cursorMod)
            if markedForPainting == false{markedForPainting = true}
        }
 
        if modArray.count > 0 {
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
        
        
    }
    
    func setCellToEndNote(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        // viabilityStatus must be in viable group
        // noteStatus must be .potentialEnd
        // cursorStatus must be .is_Current_Cursor
        // think I'll run checks in the caller - if its all three things that its supposed to be then I'll leave it
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group {
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialEnd {
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .potentialEnd
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .not_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .is_The_Current_Cursor
            modArray.append(cursorMod)
            if markedForPainting == false{markedForPainting = true}
        }
 
        if modArray.count > 0{
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
        
        
    }
        
    func set_Cell_To_Viable_Unassigned(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group {
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .unassigned {
            let potentialNoteMod = Cell_Modification(typeParam: .note_Modification)
            potentialNoteMod.note_Status_Modification_Value = .unassigned
            modArray.append(potentialNoteMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.cursor_Status == .is_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
            modArray.append(cursorMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if modArray.count > 0 {
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
    }
    
    
    
}
