//
//  Cursor_Grid_Line.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 27/04/2022.
//

import Foundation
import SwiftUI
import Combine

struct Cursor_Grid_Cell_Line_View : View {
    @ObservedObject var cursor_Grid_Cell_Line_Store : Cursor_Grid_Cell_Line_Store
    var body: some View {
        return ZStack(alignment: .topLeading){
            ForEach(cursor_Grid_Cell_Line_Store.cell_Store_Array){ cellStore in
                //Cursor_Grid_Cell_View(cell_Store: cellStore, cursor_Grid_Cell_Data: cellStore.data).offset(x: cellStore.xOffset ,y: 0)
                Cursor_Grid_Cell_View(cell_Store: cellStore).offset(x: cellStore.xOffset ,y: 0)
            }
        }.offset(x: 0, y: cursor_Grid_Cell_Line_Store.yOffset)
    }
}

class Cursor_Grid_Cell_Line_Store : ObservableObject, Identifiable {
    var id = UUID()
    var parentGridRef : Cursor_Grid_Store
    var dataLine : Cursor_Grid_Cell_Data_Line
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var cell_Store_Array : [Cursor_Grid_Cell_Store] = []
    var initial_Y_Place : Int
    
    var nextDownWardDataSwapThreshold : Int
    
    @Published var yOffset : CGFloat
    
    init(placeInArray : Int, parentGridParam:Cursor_Grid_Store){
        parentGridRef = parentGridParam
        
        nextDownWardDataSwapThreshold = placeInArray + lclDimensions.gridVerticalUnitCount
        
        dataLine = parentGridParam.cursor_Grid_Data.cell_Line_Array[placeInArray] //dataLineParam
        
        yPosition_Int = placeInArray
        
        initial_Y_Place = placeInArray
        
        yOffset = CGFloat(placeInArray)*lclDimensions.gridUnitSize

        
        for x in 0..<lclDimensions.numberCellsGridHorizontal {
            let cell_Store = Cursor_Grid_Cell_Store(placeInParentLineParam: x, dataParam: dataLine.cell_Data_Array[x])
            cell_Store_Array.append(cell_Store)
        }
        
    }
    
    // the deactiavtion of the previous cursor can be done at top level
    func activate_Cursor_By_X(xParam:Int){
        cell_Store_Array[xParam].hostingCursor = true
    }
    
    //func update_yPosition_Int(lowValParam:Int,highValParam:Int,previousLowValParam:Int?,previousHighValParam:Int?){
    func update_yPosition_Int(lowValParam:Int){
        
//        if let lclpreviousLowValParam = previousLowValParam,let lclpreviousHighValParam = previousHighValParam {
//            print("lowValParam: ",lowValParam,",highValParam: ",highValParam,",previousLowValParam: ",lclpreviousLowValParam,", previousHighValParam",lclpreviousHighValParam,", initial_Y_Place: ",initial_Y_Place)
//        }
        let newLineVal = lowValParam+initial_Y_Place
        dataSwap(newLineParam:newLineVal)
        //parentGridRef.cursor_Grid_Data.update_Data_Cursor_Y(new_Cursor_Y_Int: newLineVal)
        
//        if initial_Y_Place == 0 { dataSwap(newLineParam:lowValParam) }
//        else {dataSwap(newLineParam:lowValParam+initial_Y_Place)}
        
//        if yPosition_Int == 0 { dataSwap(newLineParam:lowValParam) }
//        else if yPosition_Int == 1 {dataSwap(newLineParam:lowValParam+1) }
//        else if yPosition_Int == 2 {dataSwap(newLineParam:lowValParam+2)}
//        else if yPosition_Int == 3 {dataSwap(newLineParam:lowValParam+3)}
//        else if yPosition_Int == 4 {dataSwap(newLineParam:lowValParam+4)}
        
        //print("lowValParam: ",lowValParam,",highValParam: ",highValParam,",previousLowValParam: ",previousHighValParam,", previousHighValParam",previousHighValParam)
        
        
//        if yPosition_Int == 0 {yPosition_Int = 4}
//        else if yPosition_Int == 1 {yPosition_Int = 0}
//        else if yPosition_Int == 2 {yPosition_Int = 1}
//        else if yPosition_Int == 3 {yPosition_Int = 2}
//        else if yPosition_Int == 4 {yPosition_Int = 3}
        
        
          //print("lowValParam: ",lowValParam.description,", highValParam: ",highValParam,", initial_Y: ",initial_Y_Place,", curr y place: ",yPosition_Int)
        
        
        

        
        
        
//        if yPosition_Int == 0 { yPosition_Int += 4 }
//        else{yPosition_Int -= 1}
        
//        if yPosition_Int == 0 {yPosition_Int = 4}
//        else if yPosition_Int == 1 {yPosition_Int = 0}
//        else if yPosition_Int == 2 {yPosition_Int = 1}
//        else if yPosition_Int == 3 {yPosition_Int = 2}
//        else if yPosition_Int == 4 {yPosition_Int = 3}
        
//        if initial_Y_Place == 0 {yPosition_Int = 4}
//        else if initial_Y_Place == 1 {yPosition_Int = 0}
//        else if initial_Y_Place == 2 {yPosition_Int = 1}
//        else if initial_Y_Place == 3 {yPosition_Int = 2}
//        else if initial_Y_Place == 4 {yPosition_Int = 3}
        
        
//        let initial_Plus_Addition = lowValParam + initial_Y_Place
//        let currbracket : Int = Int(initial_Plus_Addition/lclDimensions.gridVerticalUnitCount)
//        let subtracty = currbracket*lclDimensions.gridVerticalUnitCount
//        let adjustedResult = initial_Plus_Addition - subtracty
//        yPosition_Int = adjustedResult
//        if initial_Y_Place == 0{print("adjustedResult: ",adjustedResult.description,", initial_Y_Place: ",initial_Y_Place)}
        
        //if initial_Y_Place == 0{print("yPosition_Int: ",yPosition_Int,", initial_Y_Place: ",initial_Y_Place)}
        
        //dataSwap(newLineParam:nextDownWardDataSwapThreshold)
        //if nextDownWardDataSwapThreshold != highValParam{nextDownWardDataSwapThreshold = highValParam}
//        if nextDownWardDataSwapThreshold == highValParam{
//            dataSwap(newLineParam:nextDownWardDataSwapThreshold)
//        }
        
//        print("initialYPlace: ",initial_Y_Place, "curr data Y: ", dataLine.place_In_Parent_Line_Array.description,", highValParam: ",highValParam.description
//              , ", nextDownWardDataSwapThreshold: ",nextDownWardDataSwapThreshold,", lowValParam: ",lowValParam.description)
        
        
        
    }
    
    func dataSwap(newLineParam:Int){
        //print("curr data Y: ", dataLine.place_In_Parent_Line_Array.description,", triggerLineParam" )
        //print("proposedNewLine: ",newLineParam.description,", nextDownWardDataSwapThreshold: ",nextDownWardDataSwapThreshold.description)
        //let upperLimit = parentGridRef.cursor_Grid_Data.cell_Line_Array.count
        
        if newLineParam < parentGridRef.cursor_Grid_Data.cell_Line_Array.count {
            dataLine = parentGridRef.cursor_Grid_Data.cell_Line_Array[newLineParam]
            for x in 0..<lclDimensions.numberCellsGridHorizontal {
                cell_Store_Array[x].data = dataLine.cell_Data_Array[x]
            }
        }

        
    }
    
    func thresholdUpdate(lowValParam:Int,highValParam:Int){
        if nextDownWardDataSwapThreshold != highValParam{nextDownWardDataSwapThreshold = highValParam}
    }
    
    var yPosition_Int : Int {
        didSet {
            update_Y_Offset()
            //if initial_Y_Place == 0{print("yPosition_Int: ",yPosition_Int,", initial_Y_Place: ",initial_Y_Place)}
            
        }
    }
    
    func update_Y_Offset(){
//        let invertedYPos = (lclDimensions.gridVerticalUnitCount-1) - yPosition_Int
//        let newOffset = CGFloat(invertedYPos) * lclDimensions.gridUnitSize
//        yOffset = newOffset
          let newOffset = CGFloat(yPosition_Int) * lclDimensions.gridUnitSize
          yOffset = newOffset
    }

}
