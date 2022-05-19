//
//  Grid_Cell_Data_Note_Status.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 05/05/2022.
//

import Foundation

enum Grid_Cell_Data_Note_Status : String {
    
    
    case unassigned = "unassigned" // changed to not in a note
    
    // start - these have to go oot
    case cursor_Active_Writable = "cursor_Active_Writable"
    case cursor_Active_Prohibited = "cursor_Active_Prohibited"
    case cursor_Passive = "cursor_Passive"
    // these have to go oot - end
    
    
    case potentialSingle = "potentialSingle"
    case potentialStart = "potentialStart"
    case potentialMiddle = "potentialMiddle"
    case potentialEnd = "potentialEnd"
    
    case confirmedSingle = "confirmedSingle"
    case confirmedStart = "confirmedStart"
    case confirmedMiddle = "confirmedMiddle"
    case confirmedEnd = "confirmedEnd"
    
}

enum Grid_Cell_Data_Selectability_Status : String {
    case not_In_A_Write_Viable_Group = "not_In_A_Write_Viable_Group"
    case in_A_Write_Viable_Group = "in_A_Write_Viable_Group"
}

enum Grid_Cell_Data_Cursor_Status : String {
    case is_The_Current_Cursor = "is_The_Current_Cursor"
    case not_The_Current_Cursor = "not_Current_Cursor"
}


// do I need a class to hold a color pallette and react to the changes of any of the three and
// reselect the color config accordingly

// ok so, the Cell_Status class, will have a member of all three statuses
// there will be a function to alter cursorStatus, viableGroupMambershipStatus, noteStatus each with a single arg - newStatus
// the default for a new cell is cursorStatus - not, viableGroupMambershipStatus-not, noteStatus - not_In_A_Note
// actually there also needs to be three readable vals for this the cursor/note/inviablegroup and three functions
// so that a client object can determine whether or not there needs to be a change prior to firing them

// the didSet of each of those three visible statuses will trigger a subsequent evaluation for the final color config
