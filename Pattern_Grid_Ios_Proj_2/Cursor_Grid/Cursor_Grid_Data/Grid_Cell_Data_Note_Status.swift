//
//  Grid_Cell_Data_Note_Status.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 05/05/2022.
//

import Foundation

enum Grid_Cell_Data_Note_Status : String {
    
    case unassigned = "unassigned"

    case potentialSingle = "potentialSingle"
    case potentialStart = "potentialStart"
    case potentialMiddle = "potentialMiddle"
    case potentialEnd = "potentialEnd"
    
    case confirmedSingle = "confirmedSingle"
    case confirmedStart = "confirmedStart"
    case confirmedMiddle = "confirmedMiddle"
    case confirmedEnd = "confirmedEnd"
    
}

enum Grid_Cell_Data_In_Viable_Group_Status : String {
    case not_In_A_Write_Viable_Group = "not_In_A_Write_Viable_Group"
    case in_A_Write_Viable_Group = "in_A_Write_Viable_Group"
}

enum Grid_Cell_Data_Cursor_Status : String {
    case is_The_Current_Cursor = "is_The_Current_Cursor"
    case not_The_Current_Cursor = "not_Current_Cursor"
}

enum CELL_DATA_MODIFICATION_TYPE {
    case cursor_Modification
    case viable_Group_Memberhip_Modification
    case note_Modification
}
