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
    
    var parentDataLine : Cursor_Grid_Line_Data_Store?

    init(xParam:Int,yParam:Int){
        xNumber = xParam
        yNumber = yParam
        current_Perimeter_Color = lclColors.status_Cell_Painter.unassigned_Cell_Perimeter_Color //lclColors.cellPerimeterColor_Normal
        current_Font_Color = lclColors.status_Cell_Painter.unassigned_Cell_Font_Color//lclColors.cellFontColor_Normal
        current_BackGround_Color = lclColors.status_Cell_Painter.unassigned_Cell_Background_Color//lclColors.cellBackGroundColor_Normal
    }
    
    static func == (lhs: Cursor_Grid_Cell_Data_Store, rhs: Cursor_Grid_Cell_Data_Store) -> Bool {
        var retVal = false
        if lhs.xNumber == rhs.xNumber , lhs.yNumber == rhs.yNumber{ retVal = true }
        return retVal
    }
    
    func setParentLineData(parentDataLineParam:Cursor_Grid_Line_Data_Store){
        parentDataLine = parentDataLineParam
    }
    
    
    
    
    
    
    
    // TODO: parallell state changes -- cursor
    
    var status_Before_I_Became_The_Cursor : Grid_Cell_Data_Note_Status? = nil
    
    var grid_Cell_Data_Note_Status : Grid_Cell_Data_Note_Status = .unassigned
    {
        didSet {
            handleStatusChange()
        }
    }
    
    func handleStatusChange(){
        lclColors.status_Cell_Painter.selectColorConfig(cellDataParam: self)
    }

    func restoreToPreCursor(){
        if let previousStatus = status_Before_I_Became_The_Cursor {
            grid_Cell_Data_Note_Status = previousStatus
            status_Before_I_Became_The_Cursor = nil
        }
    }
    
    var selectability_Status : Grid_Cell_Data_Selectability_Status = .selectability_Unassigned
    
    // TODO: parallell state changes -- selectability
    func processSelectabilityUpdate(isCurrentSelectedPosition:Bool,selectabilityUpdateParam:Grid_Cell_Data_Selectability_Status?){
        
        if selectabilityUpdateParam == .selectable {
            selectability_Status = .selectable
        }
        
        else if selectabilityUpdateParam == .selectability_Unassigned {
            selectability_Status = .selectability_Unassigned
        }
        
        handleStatusChange()
        
    }
    
    // TODO: parallell state changes -- status
    func processStatusUpdate(isCurrentSelectedPosition:Bool,statusUpdateParam:Grid_Cell_Data_Note_Status?){
        
        if let lclStat = statusUpdateParam {
            print("processStatusUpdate(, isCurrentSelectedPosition: ", isCurrentSelectedPosition.description
                          ,", statusUpdateParam: ",lclStat.rawValue)
        }
        else if statusUpdateParam == nil {
            print("processStatusUpdate(, isCurrentSelectedPosition: ", isCurrentSelectedPosition.description
                          ,", statusUpdateParam: nil")
        }
        
        if let lclParentLine = parentDataLine {
            if let lclParentGrid = lclParentLine.parentGridData {

                if statusUpdateParam == nil {
                    if status_Before_I_Became_The_Cursor == nil {
                        status_Before_I_Became_The_Cursor = grid_Cell_Data_Note_Status
                        grid_Cell_Data_Note_Status = .cursor_Passive
                    }
                }
                
                else if let lclStatusUpdate = statusUpdateParam {
                    
                    if isCurrentSelectedPosition == true {
                        
                        if lclStatusUpdate == .cursor_Active_Writable {
                            status_Before_I_Became_The_Cursor = grid_Cell_Data_Note_Status
                            grid_Cell_Data_Note_Status = .cursor_Active_Writable
                        }
                        
                        else if lclStatusUpdate == .cursor_Active_Prohibited {
                            status_Before_I_Became_The_Cursor = grid_Cell_Data_Note_Status
                            grid_Cell_Data_Note_Status = .cursor_Active_Prohibited
                        }
                        
//                        else if lclStatusUpdate == .selectable {
//                            status_Before_I_Became_The_Cursor = .selectable
//                            grid_Cell_Data_Note_Status = .cursor_Active_Writable
//                        }
                        
                    }
                    else if isCurrentSelectedPosition == false {
                        grid_Cell_Data_Note_Status = lclStatusUpdate
                    }
                    
                }
            }
        }

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
