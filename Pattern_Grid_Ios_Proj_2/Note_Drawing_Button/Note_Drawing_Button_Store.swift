//
//  Drag_Illustrator_Store.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 02/05/2022.
//

import Foundation
import SwiftUI
import Combine

class Note_Drawing_Button_Store : ObservableObject {
    @Published var noteDrawingOn : Bool = false
    @Published var bgCol : Color = Color(red: 0.5, green: 1.0, blue: 0)
    
    var dragGesture : some Gesture {
       DragGesture(minimumDistance: 0, coordinateSpace: .local)
       .onChanged { val in
           if self.noteDrawingOn == false {
               self.noteDrawingOn = true
               // call function in Line_Data here
               self.bgCol = Color(red: 0.7, green: 0.8, blue: 0)
           }
       }
       .onEnded { val in
           if self.noteDrawingOn == true {
               self.noteDrawingOn = false
               self.bgCol = Color(red: 0.5, green: 1.0, blue: 0)
           }
       }
    }
}



//var dragGesture : some Gesture {
//   DragGesture(minimumDistance: 0, coordinateSpace: .local)
//   .onChanged { val in
//       if data.data_Cell_Status != .out_Of_Data_Boundaries {
//           pressDown_Control_Store.react_To_Press_Down()
//       }
//   }
//   .onEnded { val in
//       if data.data_Cell_Status != .out_Of_Data_Boundaries {
//           pressDown_Control_Store.react_To_Press_Up()
//       }
//   }
//}
