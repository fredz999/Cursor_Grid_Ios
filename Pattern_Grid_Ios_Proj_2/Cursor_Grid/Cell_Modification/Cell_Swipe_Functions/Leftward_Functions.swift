//
//  Leftward_Functions.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 31/05/2022.
//

import Foundation
import SwiftUI
import Combine

// TODO: leftward
class LeftwardNote_Expand_Leftward_Functions {
    
    var viableSetManager : Viable_Set_Manager
    
    var parent : Cell_Status_Modification_Manager
    
    init(viableSetManagerParam:Viable_Set_Manager,parentParam : Cell_Status_Modification_Manager){
        viableSetManager = viableSetManagerParam
        parent = parentParam
    }
    
    func leftwardNote_Expanding_Left_Swipe(currX:Int){
        var paintLineArray = [Cursor_Grid_Cell_Data_Store]()
        if let lclStartX = parent.starter_Cells_Index_In_ViableGroup {

            if currX+1 < lclStartX {
                
                if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialStart
                    || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToStartNote_Left(cell: viableSetManager.currentViableDataCellArray[currX], isToBeACursor: true, paintLineArray: &paintLineArray)
                    }
                }
                
                for x in (currX+1)..<lclStartX{
                    if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[x].note_Status != .potentialMiddle
                        || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions{
                            lclCell_Setting_Functions.setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }
                }
                
                if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialEnd
                    || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], paintLineArray: &paintLineArray)
                    }
                }
            }
            
            if currX+1 == lclStartX {
                //its one below - start is the potential end and the currX is the potentialStart and cursor
                if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialStart
                    || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToStartNote_Left(cell: viableSetManager.currentViableDataCellArray[currX], isToBeACursor: true, paintLineArray: &paintLineArray)
                    }
                }
                
                if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialEnd
                    || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], paintLineArray: &paintLineArray)
                    }
                }
                
            }

            for cell in paintLineArray{
                cell.repaint_Cell()
            }
            
        }
        }
    
}

class LeftwardNote_Contract_Leftward_Functions {
    
    var viableSetManager : Viable_Set_Manager
    
    var parent : Cell_Status_Modification_Manager
    
    init(viableSetManagerParam:Viable_Set_Manager,parentParam : Cell_Status_Modification_Manager){
        viableSetManager = viableSetManagerParam
        parent = parentParam
    }
    
    func leftwardNote_Contracting_Right_Swipe(currX:Int){
        var paintLineArray = [Cursor_Grid_Cell_Data_Store]()
        if let lclStartX = parent.starter_Cells_Index_In_ViableGroup {

            if currX+1 < lclStartX {
                if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialStart
                    || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToStartNote_Left(cell: viableSetManager.currentViableDataCellArray[currX], isToBeACursor: true, paintLineArray: &paintLineArray)
                    }
                }
                
                for x in (currX+1)..<lclStartX {
                    if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[x].note_Status != .potentialMiddle
                        || viableSetManager.currentViableDataCellArray[x].cursor_Status != .not_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                            lclCell_Setting_Functions.setCellsToMidNote(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }
                }
                
                if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialEnd
                    || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], paintLineArray: &paintLineArray)
                    }
                }
            }
            
            else if currX+1 == lclStartX {
                //its one below - start is the potential end and the currX is the potentialStart and cursor
                if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialStart
                    || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToStartNote_Left(cell: viableSetManager.currentViableDataCellArray[currX], isToBeACursor: true, paintLineArray: &paintLineArray)
                    }
                }
                
                if viableSetManager.currentViableDataCellArray[lclStartX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[lclStartX].note_Status != .potentialEnd
                    || viableSetManager.currentViableDataCellArray[lclStartX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToEndNote(cell: viableSetManager.currentViableDataCellArray[lclStartX], paintLineArray: &paintLineArray)
                    }
                }
            }
            else if currX == lclStartX {
                if viableSetManager.currentViableDataCellArray[currX].viable_Group_Status != .in_A_Write_Viable_Group
                    || viableSetManager.currentViableDataCellArray[currX].note_Status != .potentialStart
                    || viableSetManager.currentViableDataCellArray[currX].cursor_Status != .not_The_Current_Cursor
                {
                    if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                        lclCell_Setting_Functions.setCellToStartNote_Left(cell: viableSetManager.currentViableDataCellArray[currX], isToBeACursor: true, paintLineArray: &paintLineArray)
                    }
                }
            }
            
            //if viableSetManager.currentViableDataCellArray.count > currX+1 {
            if currX > 0 {
                for x in 0..<currX {
                    if viableSetManager.currentViableDataCellArray[x].viable_Group_Status != .in_A_Write_Viable_Group
                        || viableSetManager.currentViableDataCellArray[x].note_Status != .unassigned
                        || viableSetManager.currentViableDataCellArray[x].cursor_Status == .is_The_Current_Cursor
                    {
                        if let lclCell_Setting_Functions = parent.cell_Leftward_Setting_Functions {
                            lclCell_Setting_Functions.set_Cell_To_Viable_Unassigned(cell: viableSetManager.currentViableDataCellArray[x], paintLineArray: &paintLineArray)
                        }
                    }
                }
            }
            
            for cell in paintLineArray{
                cell.repaint_Cell()
            }
            
        }
        }
    
}

class Cell_Leftward_Setting_Functions {
    
    var parent : Cell_Status_Modification_Manager
    
    init(parentParam:Cell_Status_Modification_Manager){
        parent = parentParam
    }
 
    // remember in the leftward version the start note is the end cell
    func setCellToStartNote_Left(cell: Cursor_Grid_Cell_Data_Store,isToBeACursor: Bool,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group {
            let viabilityMod = Cell_Modification(typeParam: .viable_Group_Memberhip_Modification)
            viabilityMod.viable_Group_Membership_Modification_Value = .in_A_Write_Viable_Group
            modArray.append(viabilityMod)
            if markedForPainting == false{markedForPainting = true}
        }
        if cell.note_Status != .potentialStart {
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
        if cell.cursor_Status == .is_The_Current_Cursor {
            let cursorMod = Cell_Modification(typeParam: .cursor_Modification)
            cursorMod.cursor_Modification_Value = .not_The_Current_Cursor
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
    
    func setCellsToMidNote(cell: Cursor_Grid_Cell_Data_Store,paintLineArray : inout [Cursor_Grid_Cell_Data_Store]){
        var modArray = [Cell_Modification]()
        var markedForPainting : Bool = false
        if cell.viable_Group_Status != .in_A_Write_Viable_Group {
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
