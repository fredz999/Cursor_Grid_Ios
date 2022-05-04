//
//  Cursor_Grid_Cell_Data_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 29/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Cell_Data_Store : ObservableObject,Identifiable {
    let lclColors = ComponentColors.StaticComponentColors
    var id = UUID()
    
    @Published var yNumber : Int
    @Published var xNumber : Int
    
    // this needs to be a status enum.....or does it .....this should be a laugh
    // actually there really just needs to be a function that handle updates to this and the status enum and changes maybe three
    // colors or two or whatever
    
    @Published var isCurrentCursor : Bool = false {
        didSet {
            lclColors.return_CellData_Perimeter_Color(isCursorParam: isCurrentCursor, stateParam: grid_Cell_Data_Note_Status, returnedColor: &current_Perimeter_Color)
            lclColors.return_CellData_Font_Color(isCursorParam: isCurrentCursor, stateParam: grid_Cell_Data_Note_Status, returnedColor: &current_Font_Color)
            lclColors.return_CellData_BackGround_Color(isCursorParam: isCurrentCursor, stateParam: grid_Cell_Data_Note_Status, returnedColor: &current_BackGround_Color)
        }
    }
    
    @Published var grid_Cell_Data_Note_Status : Grid_Cell_Data_Note_Status = .unassigned
    @Published var current_Perimeter_Color : Color
    @Published var current_Font_Color : Color
    @Published var current_BackGround_Color : Color
    
//    @Published var current_Perimeter_Color : Color       cellFontColor_Normal
//    @Published var cellDataPerimeterColor : Color = Color.orange
//    @Published var cellDataBackGroundColor : Color = Color.orange
//    @Published var cellDataFontColor : Color = Color.orange
    
    init(xParam:Int,yParam:Int){
        print("Cursor_Grid_Cell_Data_Store.....................")
        xNumber = xParam
        yNumber = yParam
        current_Perimeter_Color = lclColors.cellPerimeterColor_Normal
        current_Font_Color = lclColors.cellFontColor_Normal
        current_BackGround_Color = lclColors.cellBackGroundColor_Normal
    }
    
    
    
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

enum Grid_Cell_Data_Note_Status {
    case unassigned
    
    case potentialSingle
    case potentialStart
    case potentialMiddle
    case potentialEnd
    
    case confirmedSingle
    case confirmedStart
    case confirmedMiddle
    case confirmedEnd
    
}
