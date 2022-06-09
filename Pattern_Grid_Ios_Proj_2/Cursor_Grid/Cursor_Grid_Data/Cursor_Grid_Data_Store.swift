//
//  Cursor_Grid_Data.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 27/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Data_Store : ObservableObject {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    let lclColor_Processor_2 = Color_Processor_Mk_2.Static_Color_Processor_Mk_2 

    var viable_Set_Manager = Viable_Set_Manager()
    
    var potential_Note_Manager = Potential_Note_Manager()
    
    var cell_Modification_Manager = Cell_Status_Modification_Manager(startCursorX: 0, startCursorY: 0)
    
    var cell_Line_Array : [Cursor_Grid_Line_Data_Store] = []
    
    var noteWritingActivated : Bool = false {
        didSet {
            if noteWritingActivated == true {
                cell_Modification_Manager.getCurrentViableSet_Then_Go_Thru_It()
            }
            else if noteWritingActivated == false {
                cell_Modification_Manager.finishWithViableSetForNow()
            }
        }
    }
    
    init(){
        setChildren()
    }
    
    func setChildren(){
        for y in 0..<lclDimensions.returnGridVerticalEnd(){
        let line_Data = Cursor_Grid_Line_Data_Store(lineNumberParam: y)
        line_Data.setParentGridData(parentGridParam: self)
        cell_Line_Array.append(line_Data)
        }
        
        load_Pattern()
        
        potential_Note_Manager.parent_Grid_Data = self
        cell_Modification_Manager.parentDataGrid = self
    }
    
    func load_Pattern(){
        cell_Line_Array[0].cell_Data_Array[3].note_Status = .confirmedSingle
        cell_Line_Array[0].cell_Data_Array[3].repaint_Cell()
    }
    
    func clear_Note_And_Viable_Array(){
        viable_Set_Manager.nil_Viable_Set()
        if potential_Note_Manager.potentialStartIndex != nil {
            potential_Note_Manager.nilPotentialArray()
        }
    }
    
    func execute_Viable_Array_Visual_Updates(){
        for cell in viable_Set_Manager.currentViableDataCellArray{
            cell.repaint_Cell()
        }
    }
    
    func returnSpecificCell(xVal:Int,yVal:Int)->Cursor_Grid_Cell_Data_Store{
        return cell_Line_Array[yVal].cell_Data_Array[xVal]
    }

}
