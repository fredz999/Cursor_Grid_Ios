//
//  ComponentColors.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 06/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Color_Processor_Mk_2 {
    
    private var color_Config_Bank : Color_Config_Bank
    
    var  status_Cell_Painter = Status_Cell_Painter()
    
    init(){
        color_Config_Bank = Color_Config_Bank()
    }
    
    func appearance_Update(cell:Cursor_Grid_Cell_Data_Store){
        
        if cell.viable_Group_Status == .not_In_A_Write_Viable_Group {
            if cell.cursor_Status == .not_The_Current_Cursor {
                paint_Cell_Not_Cursor_Cell_Not_In_Viable_Group(cell: cell)
            }
            else if cell.cursor_Status == .is_The_Current_Cursor {
                paint_Non_ViableGroup_Cell_Is_Cursor(cell: cell)
            }
        }
        else if cell.viable_Group_Status == .in_A_Write_Viable_Group {
            if cell.cursor_Status == .not_The_Current_Cursor {
                paint_Cell_Not_Cursor_Cell_In_Viable_Group(cell: cell)
            }
            else if cell.cursor_Status == .is_The_Current_Cursor {
                paint_Cell_Is_Cursor_Cell_In_Viable_Group(cell: cell)
            }
        }
    }
    //==================================================================
    //==================================================================
    
    func paint_Cell_Not_Cursor_Cell_In_Viable_Group(cell:Cursor_Grid_Cell_Data_Store){
        if cell.note_Status == .potentialStart {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.potentialStartColorConfig)
        }
        else if cell.note_Status == .potentialMiddle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.potentialMiddleColorConfig)
        }
        else if cell.note_Status == .potentialEnd {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.potentialEndColorConfig)
        }
        else if cell.note_Status == .confirmedSingle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else if cell.note_Status == .confirmedStart {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedStartColorConfig)
        }
        else if cell.note_Status == .confirmedMiddle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedMiddleColorConfig)
        }
        else if cell.note_Status == .confirmedEnd {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedEndColorConfig)
        }
        else {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cell_Unassigned_And_Viable_For_Selection)
        }
    }

    func paint_Cell_Is_Cursor_Cell_In_Viable_Group(cell:Cursor_Grid_Cell_Data_Store){
        if cell.note_Status == .confirmedSingle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cursor_Writable_ColorConfig)
        }
    }

    func paint_Non_ViableGroup_Cell_Is_Cursor(cell:Cursor_Grid_Cell_Data_Store){
        if cell.note_Status == .confirmedSingle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cursor_Prohibited_ColorConfig)
        }
        else if cell.note_Status == .confirmedStart {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cursor_Prohibited_ColorConfig)
        }
        else if cell.note_Status == .confirmedMiddle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cursor_Prohibited_ColorConfig)
        }
        else if cell.note_Status == .confirmedEnd {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cursor_Prohibited_ColorConfig)
        }
        else {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cursor_Passive_ColorConfig)
        }
    }

    func paint_Cell_Not_Cursor_Cell_Not_In_Viable_Group(cell:Cursor_Grid_Cell_Data_Store){

        if cell.note_Status == .confirmedSingle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else if cell.note_Status == .confirmedStart {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else if cell.note_Status == .confirmedMiddle {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else if cell.note_Status == .confirmedEnd {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else {
            paintDataCell_Color_Config(cell: cell, colorConfig: color_Config_Bank.cell_Unassigned_ColorConfig)
        }
    }
    //==================================================================
    //==================================================================
    private func paintDataCell_Color_Config(cell:Cursor_Grid_Cell_Data_Store,colorConfig:Status_Color_Config){
        cell.current_Font_Color = colorConfig.fontColor
        cell.current_Perimeter_Color = colorConfig.perimeterColor
        cell.current_BackGround_Color = colorConfig.backgroundColor
    }
    
    public static let Static_Color_Processor_Mk_2 = Color_Processor_Mk_2()
    
}

class Status_Cell_Painter {
    
    var color_Processor : Color_Processor
    var color_Config_Bank = Color_Config_Bank()

    init(){
        color_Processor = Color_Processor(color_Config_Bank_Param: color_Config_Bank)
    }
    
}

class Color_Config_Bank {
    var appBackGround : Color = Color(red: 0, green: 0, blue: 0.3)
    
    var cursor_Active_Writable_Font_Color : Color = Color(red:0,green:1,blue:0)
    var cursor_Active_Writable_Perimeter_Color : Color = Color(red:0,green:1,blue:0)
    var cursor_Active_Writable_Background_Color : Color = Color(red:0,green:0.4,blue:0)
    
    var cursor_Active_Prohibited_Font_Color : Color = Color(red:1,green:0,blue:0)
    var cursor_Active_Prohibited_Perimeter_Color : Color = Color(red:1,green:0,blue:0)
    var cursor_Active_Prohibited_Background_Color : Color = Color(red:0.4,green:0,blue:0)
    
    var cursor_Passive_Font_Color : Color = Color(red:0,green:0.7,blue:0.7)
    var cursor_Passive_Perimeter_Color : Color = Color(red:0,green:0.8,blue:0.8)
    var cursor_Passive_Background_Color : Color = Color(red:0,green:0.5,blue:0.5)
    //=========== cursor ====================================================
    var unassigned_Cell_Font_Color : Color = Color(red:0,green:1,blue:1)
    var unassigned_Cell_Perimeter_Color : Color = Color(red:0,green:1,blue:1)
    var unassigned_Cell_Background_Color : Color = Color(red:0,green:0.6,blue:0.6)
    
    var viable_Cell_Font_Color : Color = Color(red:0.7,green:0.7,blue:0.7)
    var viable_Cell_Perimeter_Color : Color = Color(red:0.7,green:0.7,blue:0.7)
    var viable_Cell_Background_Color : Color = Color(red:0.3,green:0.3,blue:0.3)
    
    var potentialSingle_Cell_Font_Color : Color = Color(red:0,green:0,blue:1)
    var potentialSingle_Cell_Perimeter_Color : Color = Color(red:0,green:0,blue:1)
    var potentialSingle_Cell_Background_Color : Color = Color(red:0,green:0,blue:0.4)
    
    var potentialStart_Cell_Font_Color : Color = Color(red:1,green:0,blue:1)
    var potentialStart_Cell_Perimeter_Color : Color = Color(red:1,green:0,blue:1)
    var potentialStart_Cell_Background_Color : Color = Color(red:0.4,green:0,blue:0.4)
    
    var potentialMiddle_Cell_Font_Color : Color = Color(red:1,green:0.5,blue:0)
    var potentialMiddle_Cell_Perimeter_Color : Color = Color(red:1,green:0.5,blue:0)
    var potentialMiddle_Cell_Background_Color : Color = Color(red:0.4,green:0.1,blue:0)
    
    var potentialEnd_Cell_Font_Color : Color = Color(red:1,green:1,blue:0.5)
    var potentialEnd_Cell_Perimeter_Color : Color = Color(red:1,green:1,blue:0.5)
    var potentialEnd_Cell_Background_Color : Color = Color(red:0.4,green:0.4,blue:0)
    
    //=========== confirmed ====================================================
    var confirmedSingle_Cell_Font_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedSingle_Cell_Perimeter_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedSingle_Cell_Background_Color : Color = Color(red:0.2,green:0.2,blue:0.4)
    
    var confirmedStart_Cell_Font_Color : Color = Color(red:0.8,green:0.8,blue:1)
    var confirmedStart_Cell_Perimeter_Color : Color = Color(red:0.5,green:0.5,blue:0.7)
    var confirmedStart_Cell_Background_Color : Color = Color(red:0.1,green:0.1,blue:0.2)
    
    var confirmedMiddle_Cell_Font_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedMiddle_Cell_Perimeter_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedMiddle_Cell_Background_Color : Color = Color(red:0.2,green:0.2,blue:0.5)
    
    var confirmedEnd_Cell_Font_Color : Color = Color(red:0.8,green:0.8,blue:1)
    var confirmedEnd_Cell_Perimeter_Color : Color = Color(red:0.8,green:0.8,blue:1)
    var confirmedEnd_Cell_Background_Color : Color = Color(red:0.6,green:0.6,blue:1)
    //===========/confirmed ====================================================
    
    var cell_Unassigned_And_Viable_For_Selection : Status_Color_Config
    
    var cell_Unassigned_ColorConfig : Status_Color_Config
    
    var cursor_Passive_ColorConfig : Status_Color_Config
    var cursor_Writable_ColorConfig : Status_Color_Config
    var cursor_Prohibited_ColorConfig : Status_Color_Config
    
    var potentialSingleColorConfig : Status_Color_Config
    var potentialStartColorConfig : Status_Color_Config
    var potentialMiddleColorConfig : Status_Color_Config
    var potentialEndColorConfig : Status_Color_Config
    
    var confirmedSingleColorConfig : Status_Color_Config
    var confirmedStartColorConfig : Status_Color_Config
    var confirmedMiddleColorConfig : Status_Color_Config
    var confirmedEndColorConfig : Status_Color_Config
    
    init(){
//        cell_Unassigned_And_Viable_For_Selection = Status_Color_Config(statusParam: .unassigned, fontColParam: viable_Cell_Font_Color
//                                                    , perimeterColParam: viable_Cell_Perimeter_Color, backgroundColParam: viable_Cell_Background_Color)
        
        cell_Unassigned_And_Viable_For_Selection = Status_Color_Config(fontColParam: viable_Cell_Font_Color
                                                    , perimeterColParam: viable_Cell_Perimeter_Color, backgroundColParam: viable_Cell_Background_Color)
        
        cell_Unassigned_ColorConfig = Status_Color_Config(fontColParam: unassigned_Cell_Font_Color
                                                       , perimeterColParam: unassigned_Cell_Perimeter_Color, backgroundColParam: unassigned_Cell_Background_Color)
        
        cursor_Passive_ColorConfig = Status_Color_Config(fontColParam: cursor_Passive_Font_Color
                                                       , perimeterColParam: cursor_Passive_Perimeter_Color
                                                       , backgroundColParam: cursor_Passive_Background_Color)
        
        cursor_Writable_ColorConfig = Status_Color_Config(fontColParam: cursor_Active_Writable_Font_Color
                                                       , perimeterColParam: cursor_Active_Writable_Perimeter_Color
                                                       , backgroundColParam: cursor_Active_Writable_Background_Color)

        cursor_Prohibited_ColorConfig = Status_Color_Config(fontColParam: cursor_Active_Prohibited_Font_Color
                                                            , perimeterColParam: cursor_Active_Prohibited_Perimeter_Color, backgroundColParam: cursor_Active_Prohibited_Background_Color)
        
        potentialSingleColorConfig = Status_Color_Config(fontColParam: potentialSingle_Cell_Font_Color
                                                       , perimeterColParam: potentialSingle_Cell_Perimeter_Color, backgroundColParam: potentialSingle_Cell_Background_Color)
        
        potentialStartColorConfig = Status_Color_Config(fontColParam: potentialStart_Cell_Font_Color
                                                       , perimeterColParam: potentialStart_Cell_Perimeter_Color, backgroundColParam: potentialStart_Cell_Background_Color)

        potentialMiddleColorConfig = Status_Color_Config(fontColParam: potentialMiddle_Cell_Font_Color
                                                       , perimeterColParam: potentialMiddle_Cell_Perimeter_Color, backgroundColParam: potentialMiddle_Cell_Background_Color)

        potentialEndColorConfig = Status_Color_Config(fontColParam: potentialEnd_Cell_Font_Color
                                                       , perimeterColParam: potentialEnd_Cell_Perimeter_Color, backgroundColParam: potentialEnd_Cell_Background_Color)

        confirmedSingleColorConfig = Status_Color_Config(fontColParam: confirmedSingle_Cell_Font_Color
                                                       , perimeterColParam: confirmedSingle_Cell_Perimeter_Color, backgroundColParam: confirmedSingle_Cell_Background_Color)

        confirmedStartColorConfig = Status_Color_Config(fontColParam: confirmedStart_Cell_Font_Color
                                                       , perimeterColParam: confirmedStart_Cell_Perimeter_Color, backgroundColParam: confirmedStart_Cell_Background_Color)

        confirmedMiddleColorConfig = Status_Color_Config(fontColParam: confirmedMiddle_Cell_Font_Color
                                                       , perimeterColParam: confirmedMiddle_Cell_Perimeter_Color, backgroundColParam: confirmedMiddle_Cell_Background_Color)

        confirmedEndColorConfig = Status_Color_Config(fontColParam: confirmedEnd_Cell_Font_Color
                                                       , perimeterColParam: confirmedEnd_Cell_Perimeter_Color, backgroundColParam: confirmedEnd_Cell_Background_Color)
    }
}

class Status_Color_Config {
    var fontColor : Color
    var perimeterColor : Color
    var backgroundColor : Color
    init(fontColParam:Color,perimeterColParam:Color,backgroundColParam:Color){
        fontColor = fontColParam
        perimeterColor = perimeterColParam
        backgroundColor = backgroundColParam
    }
}

class Color_Processor {

    var color_Config_Bank : Color_Config_Bank

    init(color_Config_Bank_Param : Color_Config_Bank){
        color_Config_Bank = color_Config_Bank_Param
    }

    func color_Evaluation_Cursor(cellDataParam : Cursor_Grid_Cell_Data_Store) {
        if cellDataParam.cursor_Status == .is_The_Current_Cursor {
            color_Evaluation_Cursor_In_Viable_Group(cellDataParam: cellDataParam)
        }
        else if cellDataParam.cursor_Status == .not_The_Current_Cursor {
            color_Evaluation_Cursor_Not_In_Viable_Group(cellDataParam: cellDataParam)
        }
    }

    func color_Evaluation_Cursor_In_Viable_Group(cellDataParam : Cursor_Grid_Cell_Data_Store) {
        if cellDataParam.viable_Group_Status == .not_In_A_Write_Viable_Group {
            color_Cell_Thats_A_Cursor_And_Is_Not_In_A_Viable_Selection_Group(cellDataParam: cellDataParam)
        }
        else if cellDataParam.viable_Group_Status == .in_A_Write_Viable_Group {
            color_Cell_Thats_A_Cursor_And_In_A_Viable_Selection_Group(cellDataParam: cellDataParam)
        }
    }

    func color_Evaluation_Cursor_Not_In_Viable_Group(cellDataParam : Cursor_Grid_Cell_Data_Store){
        if cellDataParam.viable_Group_Status == .not_In_A_Write_Viable_Group {
            color_Cell_Thats_Not_A_Cursor_And_Is_Not_In_A_Viable_Selection_Group(cellDataParam: cellDataParam)
        }
        else if cellDataParam.viable_Group_Status == .in_A_Write_Viable_Group {
            color_Cell_Thats_Not_A_Cursor_And_In_A_Viable_Selection_Group(cellDataParam: cellDataParam)
        }
    }

    //================ 4 LEAF FUNCS ====================================================================
    //================ 4 LEAF FUNCS ====================================================================
    //================ 4 LEAF FUNCS ====================================================================
    //================ 4 LEAF FUNCS ====================================================================

    func color_Cell_Thats_A_Cursor_And_In_A_Viable_Selection_Group(cellDataParam : Cursor_Grid_Cell_Data_Store){
        if cellDataParam.note_Status == .confirmedSingle {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.cursor_Writable_ColorConfig)
        }
        else if cellDataParam.note_Status == .unassigned {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.cursor_Writable_ColorConfig)
        }
    }

    func color_Cell_Thats_A_Cursor_And_Is_Not_In_A_Viable_Selection_Group(cellDataParam : Cursor_Grid_Cell_Data_Store){
        if cellDataParam.note_Status == .confirmedSingle {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.cursor_Prohibited_ColorConfig)
        }
        else if cellDataParam.note_Status == .unassigned {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.cursor_Passive_ColorConfig)
        }
    }

    func color_Cell_Thats_Not_A_Cursor_And_In_A_Viable_Selection_Group(cellDataParam : Cursor_Grid_Cell_Data_Store){
        if cellDataParam.note_Status == .unassigned {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.cell_Unassigned_And_Viable_For_Selection)
        }
    }

    func color_Cell_Thats_Not_A_Cursor_And_Is_Not_In_A_Viable_Selection_Group(cellDataParam : Cursor_Grid_Cell_Data_Store){
        if cellDataParam.note_Status == .confirmedSingle {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.confirmedSingleColorConfig)
        }
        else if cellDataParam.note_Status == .unassigned {
            paintDataCell(cell: cellDataParam, colorConfig: color_Config_Bank.cell_Unassigned_ColorConfig)
        }
    }
    //================ 4 LEAF FUNCS ====================================================================
    //================ 4 LEAF FUNCS ====================================================================
    //================ 4 LEAF FUNCS ====================================================================
    //================ 4 LEAF FUNCS ====================================================================

    func paintDataCell(cell:Cursor_Grid_Cell_Data_Store,colorConfig:Status_Color_Config){
        cell.current_Font_Color = colorConfig.fontColor
        cell.current_Perimeter_Color = colorConfig.perimeterColor
        cell.current_BackGround_Color = colorConfig.backgroundColor
    }
}
