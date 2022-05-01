//
//  Cursor_Grid_Cell_Data_Line.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 29/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Cell_Data_Line : ObservableObject, Identifiable {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var id = UUID()
    var place_In_Parent_Line_Array : Int
    var cell_Data_Array : [Cursor_Grid_Cell_Data_Store] = []
    
    init(lineNumberParam:Int){
        place_In_Parent_Line_Array = lineNumberParam
        for x in 0..<lclDimensions.numberCellsGridHorizontal {
            let data = Cursor_Grid_Cell_Data_Store(xParam: x, yParam: lineNumberParam)
            cell_Data_Array.append(data)
        }
    }
    
}
