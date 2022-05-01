//
//  Cursor_Grid_Cell_Data_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 29/04/2022.
//

import Foundation
import SwiftUI
import Combine

class Cursor_Grid_Cell_Data_Store : ObservableObject,Identifiable{
    var id = UUID()
    @Published var yNumber : Int
    @Published var xNumber : Int
    @Published var isCurrentCursor : Bool = false
    init(xParam:Int,yParam:Int){
        xNumber = xParam
        yNumber = yParam
    }
}

struct Cursor_Grid_Cell_Data_View : View {
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    @ObservedObject var cursor_Grid_Cell_Data: Cursor_Grid_Cell_Data_Store
    var body : some View {
        return ZStack(alignment: .topLeading){
            Text(cursor_Grid_Cell_Data.yNumber.description)
                .foregroundColor(cursor_Grid_Cell_Data.isCurrentCursor == true ?  .green : .red)
                .font(.system(size: lclDimensions.cursorGridDataViewFontSize))
        }
    }
}
