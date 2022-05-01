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
    var colors : Colors = Colors()
    var gridUnitSize : CGFloat = 20
    var cellPerimeterSize : CGFloat = 2
    var bgRecWidth : CGFloat = 0
    var bgRecHeight : CGFloat = 0
    
    var swipe_X_Boundary : CGFloat = 0
    var swipe_Surface_Height : CGFloat = 75
    
    var drag_Reactor_Lower_Limit : CGFloat = 0
    var drag_Reactor_Upper_Limit : CGFloat = 0
    
    //====================================================================
    var VSliderCellWidth : CGFloat = 0
    var VSliderCellHeight : CGFloat = 0
    //var VSliderFrameHeight : CGFloat = 100
    var VSliderFrameLastUnit : Int = 4
    
    var HSliderCellWidth : CGFloat = 0
    var HSliderCellHeight : CGFloat = 0
    //var HSliderFrameWidth : CGFloat = 100
    var HSliderFrameLastUnit : Int = 4
    
    //====================================================================
    var useable_Data_Range_Lower_Limit : Int = 0
    var useable_Data_Range_Upper_Limit : Int = 32
    
    var cursorOnlyAdjustment : Int = 3
    var numberCellsGridHorizontal : Int = 14
    var numberCellsSliderHorizontal : Int = 18 // the delta here appears to be derived from the size of the H_Slider
    
    var gridVerticalUnitCount : Int = 7
    var gridVerticalFinalIndex : Int = 6
    
    var central_Grid_Movement_Lower_Limit : Int = 0
    var central_Grid_Movement_Upper_Limit : Int = 27
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
        let retval = CGFloat(HSliderFrameLastUnit) * HSliderCellWidth
        return retval
    }
    
    func returnVSLiderFrameHeight()->CGFloat{
        let retval = CGFloat(VSliderFrameLastUnit) * VSliderCellHeight
        return retval
    }
    
    
    var cursorGridDataViewFontSize : CGFloat = 14
 
    
    func setupDimensions(screenWeedth:CGFloat,screenHeeight:CGFloat,callBackParam:()->()){
        //gridUnitSize = 20
        
        VSliderCellWidth = gridUnitSize
        VSliderCellHeight = gridUnitSize
        HSliderCellWidth = gridUnitSize
        HSliderCellHeight = gridUnitSize
        
        bgRecWidth = screenWeedth
        bgRecHeight = screenHeeight
        drag_Reactor_Upper_Limit = CGFloat(numberCellsGridHorizontal) * gridUnitSize
        swipe_X_Boundary = CGFloat(numberCellsGridHorizontal) * gridUnitSize
        callBackParam()
    }
    
    static let StaticComponentDimensions = ComponentDimensions()
}

class Colors {
    var cellCentre_Unselected : Color = .yellow
    var cellPerim_Unselected : Color = .black
    
    var cellCentre_Selected : Color = Color(red: 0.5, green: 1, blue: 0)
    var cellPerim_Selected : Color = Color(red: 0.3, green: 0.6, blue: 0)
    
    var appBackGround : Color = Color(red: 0, green: 0, blue: 0.3)
}
