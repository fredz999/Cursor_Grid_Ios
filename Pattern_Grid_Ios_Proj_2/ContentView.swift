//
//  ContentView.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 21/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions

//    var v_Slider_Responder_Store = V_Slider_Responder_Store()
//    var h_Slider_Responder_Store = Horizontal_Slider_Responder_Store()
//    var noteDrawingButtonStore = Note_Drawing_Button_Store()
//    @ObservedObject var cursor_Grid_Store = Cursor_Grid_Store()
    
    init(){
//        v_Slider_Responder_Store.cursor_Grid_Store = cursor_Grid_Store
//        v_Slider_Responder_Store.cursor_Grid_Data = cursor_Grid_Store.cursor_Grid_Data
//        h_Slider_Responder_Store.cursor_Grid_Data = cursor_Grid_Store.cursor_Grid_Data
//        noteDrawingButtonStore.cursor_Grid_Data_Store_Ref = cursor_Grid_Store.cursor_Grid_Data
    }
    
    @State var measurementsWereSet : Bool = false
    
    func acknowledgeMeasurementsSet(){
        self.measurementsWereSet = true
    }
    
    var body: some View {
        return ZStack(alignment: .topLeading){
            GeometryReader{ gr in
            Color.clear
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                lclDimensions.setupDimensions(screenWeedth: gr.frame(in: .local).width, screenHeeight: gr.frame(in: .local).height, callBackParam: self.acknowledgeMeasurementsSet)
            }
            }
            
            Rectangle().frame(width: lclDimensions.bgRecWidth, height: lclDimensions.bgRecHeight).foregroundColor(.red)
            
            if measurementsWereSet == true {
                Thing_With_All_The_Things_On_It()
            }
            
        }
    }
}

struct Thing_With_All_The_Things_On_It : View {

    var v_Slider_Responder_Store = Vertical_Slider_Responder_Store()
    var h_Slider_Responder_Store = Horizontal_Slider_Responder_Store()
    var noteDrawingButtonStore = Note_Drawing_Button_Store()
    var cursor_Grid_Store = Cursor_Grid_Store()
    let dimensions = ComponentDimensions.StaticComponentDimensions
    
    //var vertical_Slider_Coordinator_Store = Vertical_Slider_Coordinator_Store()
    var vertical_Slider_Coordinator_Store : Vertical_Slider_Coordinator_Store
    var horizontal_Slider_Coordinator_Store : Horizontal_Slider_Coordinator_Store
    
    init(){
    vertical_Slider_Coordinator_Store = Vertical_Slider_Coordinator_Store(vSliderResponderArrayParam: [v_Slider_Responder_Store])
    horizontal_Slider_Coordinator_Store = Horizontal_Slider_Coordinator_Store(hSliderResponderArrayParam: [h_Slider_Responder_Store])
    v_Slider_Responder_Store.cursor_Grid_Store = cursor_Grid_Store
    v_Slider_Responder_Store.cursor_Grid_Data = cursor_Grid_Store.cursor_Grid_Data
    h_Slider_Responder_Store.cursor_Grid_Data = cursor_Grid_Store.cursor_Grid_Data
    noteDrawingButtonStore.cursor_Grid_Data_Store_Ref = cursor_Grid_Store.cursor_Grid_Data
    noteDrawingButtonStore.vertical_Slider_Coordinator_Store_Ref = vertical_Slider_Coordinator_Store
    }

    var body: some View {
        
        return ZStack(alignment: .topLeading){
            
        Vertical_Slider_Container_View(vertical_Slider_Coordinator_Store: vertical_Slider_Coordinator_Store)
        .offset(x: 240, y: 240)

        Cursor_Grid_View(cursor_Grid_Store: cursor_Grid_Store)
        .offset(x: 10, y: 10)
            
        Horizontal_Slider_Container_View(h_Slider_Responder_Store: h_Slider_Responder_Store, horizontal_Slider_Coordinator_Store: horizontal_Slider_Coordinator_Store)
        .offset(x: dimensions.h_Slider_X_Offset, y: dimensions.h_Slider_Y_Offset)

        Note_Drawing_Button_View(note_Drawing_Button_Store: noteDrawingButtonStore)
        .offset(x: dimensions.return_Note_Drawing_Button_X_Pos(), y:dimensions.return_Note_Drawing_Button_Y_Pos())
            
        Button(action:{
            vertical_Slider_Coordinator_Store.vertical_GoToEnd()
        }){
            ZStack(alignment: .topLeading){
                Rectangle().frame(width: 50, height: 50).foregroundColor(Color(red: 0.5, green: 1.0, blue: 0)).cornerRadius(6)
                Text("⬇").foregroundColor(Color(red: 0, green: 0, blue: 0.4))
            }
        }.offset(x: 10, y: 360)
            
            
        }
    }
    
}

struct Vertical_Slider_Container_View : View {
    let dimensions = ComponentDimensions.StaticComponentDimensions
    @ObservedObject var vertical_Slider_Coordinator_Store : Vertical_Slider_Coordinator_Store
    var body: some View {
        return ZStack(alignment: .topLeading) {
        VStack {
        Vertical_Slider_View(vertical_Slider_Coordinator_Param: vertical_Slider_Coordinator_Store)
        .frame(width: dimensions.v_SliderCellWidth, height: dimensions.returnVSLiderFrameHeight())
        }
        }
    }
}

struct Horizontal_Slider_Container_View : View {
    let dimensions = ComponentDimensions.StaticComponentDimensions
    @ObservedObject var h_Slider_Responder_Store : Horizontal_Slider_Responder_Store
    @ObservedObject var horizontal_Slider_Coordinator_Store : Horizontal_Slider_Coordinator_Store
    var body: some View {
        return ZStack(alignment: .topLeading) {
        VStack {
        Horizontal_Slider_View(horizontal_Slider_Coordinator_Store_Param: horizontal_Slider_Coordinator_Store)
        .frame(width: dimensions.returnHSLiderFrameWidth(), height: dimensions.v_SliderCellHeight)
        }
        }.onAppear{
            DispatchQueue.main.async {
                horizontal_Slider_Coordinator_Store.horizontal_GoToEnd()
            }
        }
    }
}
