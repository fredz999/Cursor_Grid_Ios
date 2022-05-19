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
    // ref to the central data store needed heah
    @Published var noteDrawingOn : Bool = false
    @Published var bgCol : Color = Color(red: 0.6, green: 0, blue: 0)  // Color(red: 0.5, green: 1.0, blue: 0)
    @Published var txt = "Off"
    
    var cursor_Grid_Data_Store_Ref : Cursor_Grid_Data_Store?
    
    var vertical_Slider_Coordinator_Store_Ref : Vertical_Slider_Coordinator_Store?
    
    func flipNoteWriting(){
        
        if let lclDataClass = self.cursor_Grid_Data_Store_Ref {
          if lclDataClass.noteWritingActivated == false {
              
              lclDataClass.noteWritingActivated = true
              
            if let lclVSliderRef = vertical_Slider_Coordinator_Store_Ref {
                lclVSliderRef.toggleFreeze(toFreeze: true)
            }
              bgCol = Color(red: 0, green: 0.6, blue: 0)
              txt = "On"
              if let lclVSliderRef = vertical_Slider_Coordinator_Store_Ref {
                  lclVSliderRef.toggleFreeze(toFreeze: true)
              }
          }
          else if lclDataClass.noteWritingActivated == true {
              
              lclDataClass.noteWritingActivated = false
              
//              if let lclCurrData = lclDataClass.currCellData{
//                  lclDataClass.note_Writer.commit_Note(currCell: lclCurrData)
//              }
              
              if let lclVSliderRef = vertical_Slider_Coordinator_Store_Ref {
                  lclVSliderRef.toggleFreeze(toFreeze: false)
              }
              
              bgCol = Color(red: 0.6, green: 0, blue: 0)
              txt = "Off"
//              if let lclVSliderRef = vertical_Slider_Coordinator_Store_Ref {
//                  lclVSliderRef.toggleFreeze(toFreeze: false)
//              }
          }
        }

    }


}
