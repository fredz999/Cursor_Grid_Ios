//
//  Rightward_Functions.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 31/05/2022.
//

import Foundation
import SwiftUI
import Combine

class RightwardNote_Expand_Rightward_Functions{
    
    var viableSetManager : Viable_Set_Manager
    
    var parent : Cell_Status_Modification_Manager
    
    init(viableSetManagerParam:Viable_Set_Manager,parentParam : Cell_Status_Modification_Manager){
        viableSetManager = viableSetManagerParam
        parent = parentParam
    }
    
    func process_Rightward_Expansion(currX:Int){
        if let lclStartX = parent.starter_Cells_Index_In_ViableGroup {
            var paintLineArray = [Cursor_Grid_Cell_Data_Store]()
            if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
            {
                //setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
                if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                    lclCell_Setting_Functions.setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
                }
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
                        //setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }
                }
            }
            // for it to be set to end(on rightward swipe)
            // it must not be already: 1: in the viable,2:potentialEnd,3: Is_The_Cursor -- if its already all three of those things
            // it does not require processing
            
            if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialEnd
                || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .is_The_Current_Cursor
            {
                //setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                    lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                }
            }
            
            
            if viableSetManager.currentViableDataCellArray.count > currX+1 {
                for x in currX+1..<viableSetManager.currentViableDataCellArray.count {
                    if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[x].note_Status != .unassigned
                        || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.set_Cell_To_Viable_Unassigned_Right_Controct(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }

                }
            }
            for cell in paintLineArray{
                cell.repaint_Cell()
            }
        }
    }
    
    func setCellToEndNote(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
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
}

class RightwardNote_Contract_Leftward_Functions {
    
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
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
                        }
                    }
                    
                    for x in lclStartX+1..<currX {
                        if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                            || viableSetManager.currentViableDataCellArray[x].note_Status != .potentialMiddle
                            || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                        {
                            if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                                lclCell_Setting_Functions.setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                            }
                        }
                    }
                    
                    if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialEnd
                        || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .is_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                        }
                    }
                    
                }
                else if lclStartX == currX-1{
                    if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                        || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: false, paintLineArray: &paintLineArray)
                        }
                    }

                    if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialEnd
                        || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .is_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[currX], paintLineArray: &paintLineArray)
                        }
                    }
                }
            
                else if lclStartX == currX{
                    if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialStart
                        || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status == .not_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions{
                            lclCell_Setting_Functions.setCellToStartNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], isToBeACursor: true, paintLineArray: &paintLineArray)
                        }
                    }
                }
                
                if viableSetManager.currentViableDataCellArray.count > currX+1 {
                    for x in currX+1..<viableSetManager.currentViableDataCellArray.count {
                        if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                            || viableSetManager.currentViableDataCellArray[x].note_Status != .unassigned
                            || viableSetManager.currentViableDataCellArray[x].cursor_Status == .is_The_Current_Cursor
                        {
                            if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions {
                            lclCell_Setting_Functions.set_Cell_To_Viable_Unassigned_Right_Controct(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                            }
                        }
                    }
                }

            for cell in paintLineArray{
                cell.repaint_Cell()
            }
            }
        }
    
    func eliminateRightSide(){
        var paintLineArray = [Cursor_Grid_Cell_Data_Store]()
        if let lclStartX = parent.starter_Cells_Index_In_ViableGroup {
            for x in lclStartX..<viableSetManager.currentViableDataCellArray.count{
                if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[x].note_Status != .unassigned
                    || viableSetManager.currentViableDataCellArray[x].cursor_Status == .is_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Rightward_Setting_Functions {
                        lclCell_Setting_Functions.set_Cell_To_Viable_Unassigned_Right_Controct(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                    }
                }
            }
        }
        for cell in paintLineArray{
            cell.repaint_Cell()
        }
    }
    
}

class Cell_Rightward_Setting_Functions {
    var parent : Cell_Status_Modification_Manager
    init(parentParam:Cell_Status_Modification_Manager){
        parent = parentParam
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
            }
        }
        else if cell.cursor_Status == .is_The_Current_Cursor {
            if isToBeACursor == false {
                let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
                cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
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
//        else if cell.cursor_Status == .is_The_Current_Cursor {
//            if markedForPainting == false{markedForPainting = true}
//        }
 
        if modArray.count > 0{
            parent.apply_A_Bunch_Of_Modifications(cell: cell, modificationArray: modArray)
        }
        if markedForPainting == true {
            paintLineArray.append(cell)
        }
        
        
    }
        
    func set_Cell_To_Viable_Unassigned_Right_Controct(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
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
