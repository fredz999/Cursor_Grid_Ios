//
//  Cursor_Grid_Cell_Data_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 29/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Cell_Data_Store : ObservableObject,Identifiable, Equatable {
    
    @Published var current_Perimeter_Color : Color
    @Published var current_Font_Color : Color
    @Published var current_BackGround_Color : Color
    
    let lclColors = ComponentColors.StaticComponentColors
    var id = UUID()
    
    var yNumber : Int
    var xNumber : Int
    
    var place_In_Viable_Set : Int?
    
    var parentDataLine : Cursor_Grid_Line_Data_Store?

    init(xParam:Int,yParam:Int){
        xNumber = xParam
        yNumber = yParam
        current_Perimeter_Color = lclColors.status_Cell_Painter.color_Config_Bank.unassigned_Cell_Perimeter_Color
        current_Font_Color = lclColors.status_Cell_Painter.color_Config_Bank.unassigned_Cell_Font_Color
        current_BackGround_Color = lclColors.status_Cell_Painter.color_Config_Bank.unassigned_Cell_Background_Color
    }
    
    static func == (lhs: Cursor_Grid_Cell_Data_Store, rhs: Cursor_Grid_Cell_Data_Store) -> Bool {
        var retVal = false
        if lhs.xNumber == rhs.xNumber , lhs.yNumber == rhs.yNumber{ retVal = true }
        return retVal
    }
    
    func setParentLineData(parentDataLineParam:Cursor_Grid_Line_Data_Store){
        parentDataLine = parentDataLineParam
    }
    
    //=============================================
    var cursor_Status : Grid_Cell_Data_Cursor_Status = .not_The_Current_Cursor
    
    var selectability_Status : Grid_Cell_Data_Selectability_Status = .not_In_A_Write_Viable_Group
    
    var note_Status : Grid_Cell_Data_Note_Status = .unassigned
    
    var note_Status_Before_I_Becamse_The_Cursor : Grid_Cell_Data_Note_Status?
    
    func processCursorStatusUpdate(isCurrentSelectedPositionParam:Bool){

        if isCurrentSelectedPositionParam == true {
            cursor_Status = .is_The_Current_Cursor
        }
        
        else if isCurrentSelectedPositionParam == false {
            cursor_Status = .not_The_Current_Cursor
        }

        handle_StatusChange()
        
    }
    
    func processSelectabilityUpdate(selectabilityUpdateParam:Grid_Cell_Data_Selectability_Status?){
        
        if selectabilityUpdateParam == .in_A_Write_Viable_Group {
            selectability_Status = .in_A_Write_Viable_Group
        }
        
        else if selectabilityUpdateParam == .not_In_A_Write_Viable_Group {
            selectability_Status = .not_In_A_Write_Viable_Group
        }

        handle_StatusChange()
    }
    
    func processStatusUpdate(statusUpdateParam:Grid_Cell_Data_Note_Status) {
        
        note_Status = statusUpdateParam
        
        handle_StatusChange()
    }

    func handle_StatusChange(){
        colors2.updateColor_From_Cursor_Status_Change(cell: self)
    }
    
    let colors2 = Color_Processor_Mk_2.Static_Color_Processor_Mk_2
    
}



struct Cursor_Grid_Cell_Data_View : View {
    let lclColors = ComponentColors.StaticComponentColors
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    @ObservedObject var cursor_Grid_Cell_Data: Cursor_Grid_Cell_Data_Store

    var body : some View {
        return ZStack(alignment: .topLeading){
            
            Rectangle().frame(width: lclDimensions.gridUnitSize , height: lclDimensions.gridUnitSize)
                .foregroundColor(cursor_Grid_Cell_Data.current_BackGround_Color)
            Rectangle().frame(width: lclDimensions.cellDataPerimeterWidth, height: lclDimensions.cellDataPerimeterThickness)
                .foregroundColor(cursor_Grid_Cell_Data.current_Perimeter_Color)
            Rectangle().frame(width: lclDimensions.cellDataPerimeterThickness, height: lclDimensions.cellDataPerimeterDepth)
                .foregroundColor(cursor_Grid_Cell_Data.current_Perimeter_Color)

            Text(cursor_Grid_Cell_Data.yNumber.description)
            .foregroundColor(cursor_Grid_Cell_Data.current_Font_Color)
            .font(.system(size: lclDimensions.cursorGridDataViewFontSize))
            
            
        }
    }
}
