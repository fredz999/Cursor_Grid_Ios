//
//  Cursor_Update_Manager.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 19/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Update_Manager {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    var parent_Grid_Data_Store : Cursor_Grid_Data_Store?

    var current_Cursor_Line : Cursor_Grid_Line_Data_Store? {
        willSet {
            nil_In_Line_Cursor_Cell()
        }
        didSet {
            set_Current_Cursor_Cell(xParam: current_Cursor_X_Int)
        }
    }

    var current_Cursor_Cell : Cursor_Grid_Cell_Data_Store?
    {
        didSet {
            if let lcl_In_Line_Cell = current_Cursor_Cell {
                lcl_In_Line_Cell.process_Cursor_Status_Update(isCurrentSelectedPositionParam: true)
                lcl_In_Line_Cell.repaint_Cell()
            }
        }
    }
    
    func set_Current_Cursor_Cell(xParam:Int){
        if let lcl_current_Cursor_Line = current_Cursor_Line {
            current_Cursor_Cell = lcl_current_Cursor_Line.cell_Data_Array[xParam]
        }
    }
    
    func nil_In_Line_Cursor_Cell(){
        if let lclin_Line_Cursor_Cell = current_Cursor_Cell {
            lclin_Line_Cursor_Cell.process_Cursor_Status_Update(isCurrentSelectedPositionParam: false)
            lclin_Line_Cursor_Cell.repaint_Cell()
            current_Cursor_Cell = nil
        }
    }
    
    var current_Cursor_X_Int : Int = 0
    
    var current_Cursor_Y_Int : Int = 0

    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int) {
                if let lclParent = parent_Grid_Data_Store {
                if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= lclParent.cell_Line_Array.count {
                if new_Cursor_Y_Int != current_Cursor_Y_Int {
                current_Cursor_Y_Int = new_Cursor_Y_Int
                current_Cursor_Line = lclParent.cell_Line_Array[new_Cursor_Y_Int]
                }
            }
        }
    }
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
        
        if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
            
            if new_Cursor_X_Int != current_Cursor_X_Int {
            nil_In_Line_Cursor_Cell()
            current_Cursor_X_Int = new_Cursor_X_Int
            set_Current_Cursor_Cell(xParam: current_Cursor_X_Int)
                
            if let lclParentGrid = parent_Grid_Data_Store {

                if lclParentGrid.noteWritingActivated == true {
                    
                    if lclParentGrid.viable_Set_Manager.viable_Set_Formed == true {
                        if let lclHigher = lclParentGrid.viable_Set_Manager.currentHighestViableCell_X_Index
                            , let lclLower = lclParentGrid.viable_Set_Manager.currentLowestViableCell_X_Index {
                            if current_Cursor_X_Int > lclHigher || current_Cursor_X_Int < lclLower {
                                // TODO: terminateNote
                                lclParentGrid.clear_Note_And_Viable_Array()
                            }
                            // TODO: append note write
                            else if current_Cursor_X_Int <= lclHigher , current_Cursor_X_Int >= lclLower {
                                if let lclCurrLine = current_Cursor_Line {
                                    if let curr_Viable_Index = lclCurrLine.cell_Data_Array[current_Cursor_X_Int].place_In_Viable_Set {
                                        lclParentGrid.potential_Note_Manager.set_PotentialNote_EndIndex(indexParam: curr_Viable_Index)
                                    }
                                }
                            }
                        }
                    }
//                    else if lclParentGrid.viable_Set_Manager.viable_Set_Formed == false {
//                        lclParentGrid.execute_Viable_Array_State_Changes()
//                        lclParentGrid.execute_Viable_Array_Visual_Updates()
//                    }
                }
            }
            }
        }
    }
}
