//
//  Mobieus_Grid.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 21/04/2022.
//

import Foundation
import SwiftUI
import Combine

struct Cursor_Grid_View : View {
    @ObservedObject var cursor_Grid_Store : Cursor_Grid_Store
    var body: some View {
        return ZStack(alignment: .topLeading){
            ForEach(cursor_Grid_Store.cursor_Grid_Cell_Line_Array){ lineStore in
                Cursor_Grid_Cell_Line_View(cursor_Grid_Cell_Line_Store: lineStore)
            }
        }
    }
}

class Cursor_Grid_Store : ObservableObject {
    let dimensions = ComponentDimensions.StaticComponentDimensions
    var cursor_Grid_Data : Cursor_Grid_Data
    @Published var cursor_Grid_Cell_Line_Array : [Cursor_Grid_Cell_Line_Store] = []
    
    init(){
        cursor_Grid_Data = Cursor_Grid_Data()
        for d in 0..<dimensions.gridVerticalUnitCount {
        let lineStore = Cursor_Grid_Cell_Line_Store(placeInArray: d, parentGridParam: self)
        cursor_Grid_Cell_Line_Array.append(lineStore)
        }
    }

    func updateLineArrayPositions(currLowValParam:Int) {
        for connected_Line_Store in cursor_Grid_Cell_Line_Array {
        connected_Line_Store.update_yPosition_Int(lowValParam: currLowValParam)
        }
    }
    
}
