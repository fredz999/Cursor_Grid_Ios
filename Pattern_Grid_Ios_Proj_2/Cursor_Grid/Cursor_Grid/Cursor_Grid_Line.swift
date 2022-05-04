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
    var dataLine : Cursor_Grid_Line_Data_Store
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var cell_Store_Array : [Cursor_Grid_Cell_Store] = []
    var initial_Y_Place : Int
    
    var nextDownWardDataSwapThreshold : Int
    
    @Published var yOffset : CGFloat
    
    init(placeInArray : Int, parentGridParam:Cursor_Grid_Store){
        parentGridRef = parentGridParam
        
        nextDownWardDataSwapThreshold = placeInArray + lclDimensions.cursor_GridVerticalUnitCount
        
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
    
    func activate_Cursor_By_X(xParam:Int) {
        //cell_Store_Array[xParam].hostingCursor = true
        print("setting aff the cursor assignment")
    }
    
    //func update_yPosition_Int(lowValParam:Int,highValParam:Int,previousLowValParam:Int?,previousHighValParam:Int?){
    func update_yPosition_Int(lowValParam:Int){
        let newLineVal = lowValParam+initial_Y_Place
        dataSwap(newLineParam:newLineVal)
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
