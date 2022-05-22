//
//  Cursor_Grid_Cell_.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 27/04/2022.
//

import Foundation
import SwiftUI
import Combine

struct Cursor_Grid_Cell_View : View {
    @ObservedObject var cell_Store : Cursor_Grid_Cell_Store
    var body: some View {
        return ZStack(alignment: .topLeading){
            Rectangle().frame(width: cell_Store.lclDimensions.gridUnitSize, height: cell_Store.lclDimensions.gridUnitSize).foregroundColor(.black)
            Cursor_Grid_Cell_Data_View(cursor_Grid_Cell_Data: cell_Store.data)
        }
    }
}

class Cursor_Grid_Cell_Store : ObservableObject,Identifiable {
    
    var id = UUID()
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var placeInParentLine : Int

    @Published var data : Cursor_Grid_Cell_Data_Store
    @Published var xOffset : CGFloat

    init(placeInParentLineParam:Int,dataParam : Cursor_Grid_Cell_Data_Store){
    data = dataParam
    placeInParentLine = placeInParentLineParam
    xOffset = CGFloat(placeInParentLineParam)*lclDimensions.gridUnitSize
    }

}
