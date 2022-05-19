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
    
    var parent_Grid_Data_Store : Cursor_Grid_Data_Store?

    var current_Cursor_Line : Cursor_Grid_Line_Data_Store? {
        willSet {
            if let lcl_current_Cursor_Line = current_Cursor_Line {
                lcl_current_Cursor_Line.nil_In_Line_Cursor_Cell()
            }
        }
        didSet {
            if let lcl_current_Cursor_Line = current_Cursor_Line {
                lcl_current_Cursor_Line.set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)
            }
        }
    }
    
    var current_Cursor_Y_Int : Int = 0
    
    func update_Data_Cursor_Y(new_Cursor_Y_Int:Int){
        if let lclParent = parent_Grid_Data_Store {
            
            if new_Cursor_Y_Int >= 0 , new_Cursor_Y_Int <= lclParent.cell_Line_Array.count {
                
                if new_Cursor_Y_Int != current_Cursor_Y_Int {
                    
                    current_Cursor_Y_Int = new_Cursor_Y_Int
                    
                    current_Cursor_Line = lclParent.cell_Line_Array[new_Cursor_Y_Int]
                    
                    //currCellData = cell_Line_Array[new_Cursor_Y_Int].return_Inverse_Cell(x_Param: current_Cursor_X_Int)

                    //current_Cursor_Line = new_Cursor_Y_Int
                    
    //                if noteWritingActivated == true {
    //                    note_UpDate_Handler()
    //                }
    //
    //                else if noteWritingActivated == false {
                    
    //                    if let lclCurrData = currCellData {
    //                        lclCurrData.processCursorStatusUpdate(isCurrentSelectedPositionParam: true)
    //                    }
                    
                    
    //                }
        }

                
            }
        }
    }
    
    var current_Cursor_X_Int : Int = 0
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    func update_Data_Cursor_X(new_Cursor_X_Int:Int) {
        if let lclParent = parent_Grid_Data_Store {
            if new_Cursor_X_Int >= 0, new_Cursor_X_Int < lclDimensions.numberCellsGridHorizontal {
                
                if new_Cursor_X_Int != current_Cursor_X_Int {
                    
                lclParent.cell_Line_Array[current_Cursor_Y_Int].nil_In_Line_Cursor_Cell()

                current_Cursor_X_Int = new_Cursor_X_Int
                    
                lclParent.cell_Line_Array[current_Cursor_Y_Int].set_In_Line_Cursor_Cell(xParam: current_Cursor_X_Int)

                }

            }
        }
    }
    
    var currCellData : Cursor_Grid_Cell_Data_Store?
    
}
