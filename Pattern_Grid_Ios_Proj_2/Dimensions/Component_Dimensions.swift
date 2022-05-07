//
//  Component_Dimensions.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 21/04/2022.
//

import Foundation
import SwiftUI
import Combine

class ComponentDimensions {
    var colors : ComponentColors = ComponentColors.StaticComponentColors
    var gridUnitSize : CGFloat = 20
    var cellPerimeterSize : CGFloat = 2
    var bgRecWidth : CGFloat = 0
    var bgRecHeight : CGFloat = 0
    
    var swipe_X_Boundary : CGFloat = 0
    var swipe_Surface_Height : CGFloat = 75
    
    var drag_Reactor_Lower_Limit : CGFloat = 0
    var drag_Reactor_Upper_Limit : CGFloat = 0
    
    //====================================================================
    var v_SliderCellWidth : CGFloat = 0
    var v_SliderCellHeight : CGFloat = 0
    //var VSliderFrameHeight : CGFloat = 100
    var VSliderFrameLastUnit : Int = 4
    
    
    var h_SliderCellWidth : CGFloat = 0
    var h_SliderCellHeight : CGFloat = 0
    //var HSliderFrameWidth : CGFloat = 100
    var h_SliderFrameLastUnit : Int = 4
    var h_Slider_X_Offset : CGFloat = 120
    var h_Slider_Y_Offset : CGFloat = 180
    
    //====================================================================
    var useable_Data_Range_Lower_Limit : Int = 0
    var useable_Data_Range_Upper_Limit : Int = 34
    
    var cursorOnlyAdjustment : Int = 3
    var numberCellsGridHorizontal : Int = 14
    var numberCellsSliderHorizontal : Int = 17 // the delta here appears to be derived from the size of the H_Slider
    
    var cursor_GridVerticalUnitCount : Int = 7
    var cursor_GridVerticalFinalIndex : Int = 6
    
    var cursor_Grid_Movement_Lower_Limit : Int = 0
    var cursor_Grid_Movement_Upper_Limit : Int = 27
    //====================================================================
    
    //======================== note_Drawing_Button_ ======================
    var note_Drawing_Button_WidthUnits : Int = 5
    var note_Drawing_Button_HeightUnits : Int = 2
    
    var note_Drawing_Button_X_Unit_Pos : Int = 1
    var note_Drawing_Button_Y_Unit_Pos : Int = 8
    //========================= cellData drawing measurements ============
    var cellDataPerimeterThickness : CGFloat = 1
    var cellDataPerimeterWidth : CGFloat = 18
    var cellDataPerimeterDepth : CGFloat = 18
    //====================================================================
    func return_Note_Drawing_Button_Width() -> CGFloat { 
        let retVal = CGFloat(note_Drawing_Button_WidthUnits) * gridUnitSize
        return retVal
    }
    
    func return_Note_Drawing_Button_Height() -> CGFloat {
        let retVal = CGFloat(note_Drawing_Button_HeightUnits) * gridUnitSize
        return retVal
    }
    
    func return_Note_Drawing_Button_X_Pos() -> CGFloat {
        let retVal = CGFloat(note_Drawing_Button_X_Unit_Pos) * gridUnitSize
        return retVal
    }
    
    func return_Note_Drawing_Button_Y_Pos() -> CGFloat {
        let retVal = CGFloat(note_Drawing_Button_Y_Unit_Pos) * gridUnitSize
        return retVal
    }
    
    //====================================================================
    func returnGridVerticalStart()->Int{
        let retVal = useable_Data_Range_Lower_Limit - cursorOnlyAdjustment
        return retVal
    }
    
    func returnGridVerticalEnd()->Int{
        let retVal = useable_Data_Range_Upper_Limit + cursorOnlyAdjustment
        return retVal
    }
    
    func returnHSLiderFrameWidth()->CGFloat{
        let retval = CGFloat(h_SliderFrameLastUnit) * h_SliderCellWidth
        return retval
    }
    
    func returnVSLiderFrameHeight()->CGFloat{
        let retval = CGFloat(VSliderFrameLastUnit) * v_SliderCellHeight
        return retval
    }
    
    //====================================================================
    
    var cursorGridDataViewFontSize : CGFloat = 14
 
    
    func setupDimensions(screenWeedth:CGFloat,screenHeeight:CGFloat,callBackParam:()->()){

        v_SliderCellWidth = gridUnitSize
        v_SliderCellHeight = gridUnitSize
        h_SliderCellWidth = gridUnitSize
        h_SliderCellHeight = gridUnitSize
        
        bgRecWidth = screenWeedth
        bgRecHeight = screenHeeight
        drag_Reactor_Upper_Limit = CGFloat(numberCellsGridHorizontal) * gridUnitSize
        swipe_X_Boundary = CGFloat(numberCellsGridHorizontal) * gridUnitSize
        callBackParam()
    }
    
    static let StaticComponentDimensions = ComponentDimensions()
}
