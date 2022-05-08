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
    
    static func == (lhs: Cursor_Grid_Cell_Data_Store, rhs: Cursor_Grid_Cell_Data_Store) -> Bool {
        var retVal = false
        if lhs.xNumber == rhs.xNumber , lhs.yNumber == rhs.yNumber{retVal = true}
        return retVal
    }
    
    
    let lclColors = ComponentColors.StaticComponentColors
    var id = UUID()
    
    var yNumber : Int
    var xNumber : Int
    
    var status_Before_I_Became_The_Cursor : Grid_Cell_Data_Note_Status? = nil
    var grid_Cell_Data_Note_Status : Grid_Cell_Data_Note_Status = .unassigned
    {
        didSet {
            handleStatusChange()
        }
    }
    
    func processStatusUpdate(isCurrentSelectedPosition:Bool,statusUpdateParam:Grid_Cell_Data_Note_Status?){
        if let lclUpdate = statusUpdateParam {
            if isCurrentSelectedPosition == false {
                grid_Cell_Data_Note_Status = lclUpdate
            }
            else if isCurrentSelectedPosition == true {
                status_Before_I_Became_The_Cursor = lclUpdate
                grid_Cell_Data_Note_Status = .cursor_Writable
            }
        }
        else if statusUpdateParam == nil {
            if isCurrentSelectedPosition == true {
                if grid_Cell_Data_Note_Status == .unassigned {
                    status_Before_I_Became_The_Cursor = .unassigned
                    grid_Cell_Data_Note_Status = .cursor_Writable
                }
                else if grid_Cell_Data_Note_Status != .unassigned {
                    status_Before_I_Became_The_Cursor = grid_Cell_Data_Note_Status
                    grid_Cell_Data_Note_Status = .cursor_Prohibited
                }
            }
        }
    }
    
    

    func handleStatusChange(){
        lclColors.status_Cell_Painter.selectColorConfig(cellDataParam: self)
    }
    
    @Published var current_Perimeter_Color : Color
    @Published var current_Font_Color : Color
    @Published var current_BackGround_Color : Color
    
    init(xParam:Int,yParam:Int){
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


