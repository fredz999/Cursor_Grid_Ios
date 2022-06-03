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
        }
        
    }

}
