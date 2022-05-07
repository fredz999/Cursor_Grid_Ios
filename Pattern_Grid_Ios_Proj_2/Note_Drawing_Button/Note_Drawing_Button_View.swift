//
//  Drag_Illustrator_View.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 02/05/2022.
//

import Foundation
import SwiftUI
import Combine

struct Note_Drawing_Button_View: View {
    @ObservedObject var note_Drawing_Button_Store : Note_Drawing_Button_Store
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var body: some View {
        return ZStack(alignment: .topLeading){
            Rectangle()
            .frame(width: lclDimensions.return_Note_Drawing_Button_Width(), height: lclDimensions.return_Note_Drawing_Button_Height())
            .foregroundColor(note_Drawing_Button_Store.bgCol)
            VStack(alignment: .leading) {
                Text("Write Note").font(.system(size: 14)).foregroundColor(.white)
                Text(note_Drawing_Button_Store.txt).font(.system(size: 14)).foregroundColor(.white)
            }
            
        }.onTapGesture {
            note_Drawing_Button_Store.flipNoteWriting()
        }
    }
}
