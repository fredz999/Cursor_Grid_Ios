//
//  Grid_Cell_Data_Note_Status.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 05/05/2022.
//

import Foundation

enum Grid_Cell_Data_Note_Status : String {
    case selectable = "selectable"
    
    case unassigned = "unassigned"
    
    case cursor_Writable = "cursor_Writable"
    case cursor_Prohibited = "cursor_Prohibited"
    
    case potentialSingle = "potentialSingle"
    case potentialStart = "potentialStart"
    case potentialMiddle = "potentialMiddle"
    case potentialEnd = "potentialEnd"
    
    case confirmedSingle = "confirmedSingle"
    case confirmedStart = "confirmedStart"
    case confirmedMiddle = "confirmedMiddle"
    case confirmedEnd = "confirmedEnd"
    
}
