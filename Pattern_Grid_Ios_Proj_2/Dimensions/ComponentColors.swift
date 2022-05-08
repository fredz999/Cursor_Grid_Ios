//
//  ComponentColors.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 06/05/2022.
//

import Foundation
import SwiftUI
import Combine

class ComponentColors {
    
    var cellBackGroundColor_Normal : Color = Color(red: 0.6, green: 0, blue: 0)
    var cellBackGroundColor_IsCursor : Color = Color(red: 0, green: 0.6, blue: 0.6)
    
    var cellFontColor_Normal : Color = .white
    var cellFontColor_IsCursor : Color = Color(red: 0, green: 1, blue: 1)
    
    var cellPerimeterColor_Normal : Color = Color(red: 0.2, green: 0, blue: 0)
    var cellPerimeterColor_IsCursor : Color = Color(red: 0, green: 1, blue: 1)
    
    var status_Cell_Painter = Status_Cell_Painter()
    
    var appBackGround : Color = Color(red: 0, green: 0, blue: 0.3)
    
    static let StaticComponentColors = ComponentColors()
}

class Status_Cell_Painter {
    var cursor_Writable_Font_Color : Color = Color(red:0,green:1,blue:0)
    var cursor_Writable_Perimeter_Color : Color = Color(red:0,green:1,blue:0)
    var cursor_Writable_Background_Color : Color = Color(red:0,green:0.4,blue:0)
    
    var cursor_Prohibited_Font_Color : Color = Color(red:1,green:0,blue:0)
    var cursor_Prohibited_Perimeter_Color : Color = Color(red:1,green:0,blue:0)
    var cursor_Prohibited_Background_Color : Color = Color(red:0.4,green:0,blue:0)
    
    var unassigned_Font_Color : Color = Color(red:0,green:1,blue:1)
    var unassigned_Perimeter_Color : Color = Color(red:0,green:1,blue:1)
    var unassigned_Background_Color : Color = Color(red:0,green:0.6,blue:0.6)
    
    var selectable_Font_Color : Color = Color(red:0,green:1,blue:0)
    var selectable_Perimeter_Color : Color = Color(red:0,green:1,blue:0)
    var selectable_Background_Color : Color = Color(red:0,green:0.3,blue:0)
    
    var potentialSingle_Font_Color : Color = Color(red:0,green:0,blue:1)
    var potentialSingle_Perimeter_Color : Color = Color(red:0,green:0,blue:1)
    var potentialSingle_Background_Color : Color = Color(red:0,green:0,blue:0.4)
    
    var potentialStart_Font_Color : Color = Color(red:1,green:0,blue:1)
    var potentialStart_Perimeter_Color : Color = Color(red:1,green:0,blue:1)
    var potentialStart_Background_Color : Color = Color(red:0.4,green:0,blue:0.4)
    
    var potentialMiddle_Font_Color : Color = Color(red:1,green:0.5,blue:0)
    var potentialMiddle_Perimeter_Color : Color = Color(red:1,green:0.5,blue:0)
    var potentialMiddle_Background_Color : Color = Color(red:0.4,green:0.1,blue:0)
    
    var potentialEnd_Font_Color : Color = Color(red:1,green:1,blue:0.5)
    var potentialEnd_Perimeter_Color : Color = Color(red:1,green:1,blue:0.5)
    var potentialEnd_Background_Color : Color = Color(red:0.4,green:0.4,blue:0)
    
    //=========== confirmed ====================================================
    var confirmedSingle_Font_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedSingle_Perimeter_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedSingle_Background_Color : Color = Color(red:0.2,green:0.2,blue:0.4)
    
    var confirmedStart_Font_Color : Color = Color(red:0.8,green:0.8,blue:1)
    var confirmedStart_Perimeter_Color : Color = Color(red:0.5,green:0.5,blue:0.7)
    var confirmedStart_Background_Color : Color = Color(red:0.1,green:0.1,blue:0.2)
    
    var confirmedMiddle_Font_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedMiddle_Perimeter_Color : Color = Color(red:0.7,green:0.7,blue:1)
    var confirmedMiddle_Background_Color : Color = Color(red:0.2,green:0.2,blue:0.5)
    
    var confirmedEnd_Font_Color : Color = Color(red:0.8,green:0.8,blue:1)
    var confirmedEnd_Perimeter_Color : Color = Color(red:0.8,green:0.8,blue:1)
    var confirmedEnd_Background_Color : Color = Color(red:0.6,green:0.6,blue:1)
    //===========/confirmed ====================================================
    
    var selectableColorConfig : Status_Color_Config
    
    var unassignedColorConfig : Status_Color_Config
    
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
        
        selectableColorConfig = Status_Color_Config(statusParam: .unassigned, fontColParam: selectable_Font_Color
                                                    , perimeterColParam: selectable_Perimeter_Color, backgroundColParam: selectable_Background_Color)
        
        unassignedColorConfig = Status_Color_Config(statusParam: .unassigned, fontColParam: unassigned_Font_Color
                                                       , perimeterColParam: unassigned_Perimeter_Color, backgroundColParam: unassigned_Background_Color)
        
        cursor_Writable_ColorConfig = Status_Color_Config(statusParam: .cursor_Writable, fontColParam: cursor_Writable_Font_Color
                                                       , perimeterColParam: cursor_Writable_Perimeter_Color, backgroundColParam: cursor_Writable_Background_Color)

        cursor_Prohibited_ColorConfig = Status_Color_Config(statusParam: .cursor_Prohibited, fontColParam: cursor_Prohibited_Font_Color
                                                            , perimeterColParam: cursor_Prohibited_Perimeter_Color, backgroundColParam: cursor_Prohibited_Background_Color)
        
        potentialSingleColorConfig = Status_Color_Config(statusParam: .potentialSingle, fontColParam: potentialSingle_Font_Color
                                                       , perimeterColParam: potentialSingle_Perimeter_Color, backgroundColParam: potentialSingle_Background_Color)
        
        potentialStartColorConfig = Status_Color_Config(statusParam: .potentialStart, fontColParam: potentialStart_Font_Color
                                                       , perimeterColParam: potentialStart_Perimeter_Color, backgroundColParam: potentialStart_Background_Color)

        potentialMiddleColorConfig = Status_Color_Config(statusParam: .potentialMiddle, fontColParam: potentialMiddle_Font_Color
                                                       , perimeterColParam: potentialMiddle_Perimeter_Color, backgroundColParam: potentialMiddle_Background_Color)

        potentialEndColorConfig = Status_Color_Config(statusParam: .potentialEnd, fontColParam: potentialEnd_Font_Color
                                                       , perimeterColParam: potentialEnd_Perimeter_Color, backgroundColParam: potentialEnd_Background_Color)

        confirmedSingleColorConfig = Status_Color_Config(statusParam: .confirmedSingle, fontColParam: confirmedSingle_Font_Color
                                                       , perimeterColParam: confirmedSingle_Perimeter_Color, backgroundColParam: confirmedSingle_Background_Color)

        confirmedStartColorConfig = Status_Color_Config(statusParam: .confirmedStart, fontColParam: confirmedStart_Font_Color
                                                       , perimeterColParam: confirmedStart_Perimeter_Color, backgroundColParam: confirmedStart_Background_Color)

        confirmedMiddleColorConfig = Status_Color_Config(statusParam: .confirmedMiddle, fontColParam: confirmedMiddle_Font_Color
                                                       , perimeterColParam: confirmedMiddle_Perimeter_Color, backgroundColParam: confirmedMiddle_Background_Color)

        confirmedEndColorConfig = Status_Color_Config(statusParam: .confirmedEnd, fontColParam: confirmedEnd_Font_Color
                                                       , perimeterColParam: confirmedEnd_Perimeter_Color, backgroundColParam: confirmedEnd_Background_Color)
    }
    

    func selectColorConfig(cellDataParam : Cursor_Grid_Cell_Data_Store){

        if cellDataParam.grid_Cell_Data_Note_Status == .unassigned{paintDataCell(cell: cellDataParam, colorConfig: unassignedColorConfig)}
        
        else if cellDataParam.grid_Cell_Data_Note_Status == .selectable{paintDataCell(cell: cellDataParam, colorConfig: selectableColorConfig)}
        
        else if cellDataParam.grid_Cell_Data_Note_Status == .cursor_Writable {
            paintDataCell(cell: cellDataParam, colorConfig: cursor_Writable_ColorConfig)
        }
        
        else if cellDataParam.grid_Cell_Data_Note_Status == .cursor_Prohibited {
            paintDataCell(cell: cellDataParam, colorConfig: cursor_Prohibited_ColorConfig)
        }

        else if cellDataParam.grid_Cell_Data_Note_Status == .potentialSingle{ paintDataCell(cell: cellDataParam, colorConfig: potentialSingleColorConfig)}
        else if cellDataParam.grid_Cell_Data_Note_Status == .potentialStart{  paintDataCell(cell: cellDataParam, colorConfig: potentialStartColorConfig)}
        else if cellDataParam.grid_Cell_Data_Note_Status == .potentialMiddle{  paintDataCell(cell: cellDataParam, colorConfig: potentialMiddleColorConfig)}
        else if cellDataParam.grid_Cell_Data_Note_Status == .potentialEnd{  paintDataCell(cell: cellDataParam, colorConfig: potentialEndColorConfig)}

        else if cellDataParam.grid_Cell_Data_Note_Status == .confirmedSingle{  paintDataCell(cell: cellDataParam, colorConfig: confirmedSingleColorConfig)}
        else if cellDataParam.grid_Cell_Data_Note_Status == .confirmedStart{  paintDataCell(cell: cellDataParam, colorConfig: confirmedStartColorConfig)  }
        else if cellDataParam.grid_Cell_Data_Note_Status == .confirmedMiddle{  paintDataCell(cell: cellDataParam, colorConfig: confirmedMiddleColorConfig)  }
        else if cellDataParam.grid_Cell_Data_Note_Status == .confirmedEnd{  paintDataCell(cell: cellDataParam, colorConfig: confirmedEndColorConfig)  }
    
    }
    
    //func paintDataCell(cell:inout Cursor_Grid_Cell_Data_Store,colorConfig:Status_Color_Config){
    func paintDataCell(cell:Cursor_Grid_Cell_Data_Store,colorConfig:Status_Color_Config){
        cell.current_Font_Color = colorConfig.fontColor
        cell.current_Perimeter_Color = colorConfig.perimeterColor
        cell.current_BackGround_Color = colorConfig.backgroundColor
    }
    
}

class Status_Color_Config {
    var status : Grid_Cell_Data_Note_Status
    var fontColor : Color
    var perimeterColor : Color
    var backgroundColor : Color
    init(statusParam:Grid_Cell_Data_Note_Status,fontColParam:Color,perimeterColParam:Color,backgroundColParam:Color){
        status = statusParam
        fontColor = fontColParam
        perimeterColor = perimeterColParam
        backgroundColor = backgroundColParam
    }
}
