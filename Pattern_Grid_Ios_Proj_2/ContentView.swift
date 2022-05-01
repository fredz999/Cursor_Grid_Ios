//
//  ContentView.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 21/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    
    @State var bgWidth : CGFloat = 0
    @State var bgHeight : CGFloat = 0
    @State var measurementsWereSet : Bool = false
    
    func acknowledgeMeasurementsSet(){
        bgWidth = lclDimensions.bgRecWidth
        bgHeight = lclDimensions.bgRecHeight
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
            
            Rectangle().frame(width: bgWidth, height: bgHeight).foregroundColor(.red)
            
            if measurementsWereSet == true {
                Thing_With_All_The_Things_On_It()
            }
            
        }
    }
}

struct Thing_With_All_The_Things_On_It : View {
    
    @ObservedObject var v_Slider_Responder_Store = V_Slider_Responder_Store()
    @ObservedObject var h_Slider_Responder_Store = H_Slider_Responder_Store()
    
    //@ObservedObject var HSlide_Responder = H_Slider_Responder_Store()
    
    let dimensions = ComponentDimensions.StaticComponentDimensions
    @ObservedObject var cursor_Grid_Store = Cursor_Grid_Store()
    
    init(){
        v_Slider_Responder_Store.cursor_Grid_Store = cursor_Grid_Store
        v_Slider_Responder_Store.cursor_Grid_Data = cursor_Grid_Store.cursor_Grid_Data
        h_Slider_Responder_Store.cursor_Grid_Data = cursor_Grid_Store.cursor_Grid_Data
    }

    var body: some View {
        return ZStack(alignment: .topLeading){
            
        Vertical_Slider_View(vSliderResponderArrayParam: [v_Slider_Responder_Store])
                .frame(width: dimensions.VSliderCellWidth, height: dimensions.returnVSLiderFrameHeight()).offset(x: 300, y: 10)
            
        Horizontal_Slider_View(hSliderResponderArrayParam: [h_Slider_Responder_Store])
                .frame(width: dimensions.returnHSLiderFrameWidth(), height: dimensions.VSliderCellHeight).offset(x: 10, y: 175)
            
        Cursor_Grid_View(cursor_Grid_Store: cursor_Grid_Store).offset(x: 10, y: 10)
            
        }
    }
    
}


class H_Slider_Responder_Store : ObservableObject, P_HSlider_Responder {
    let lclDimensions = ComponentDimensions.StaticComponentDimensions
    var cursor_Grid_Data : Cursor_Grid_Data?     //= cursor_Grid_Store.cursor_Grid_Data
    
    var current_X_Bracket : Int?{
        didSet{
            if let lclCurrent_X_Bracket = current_X_Bracket{
                //print("lclCurrent_X_Bracket: ",lclCurrent_X_Bracket.description)
                if let lclGrid_Data = cursor_Grid_Data{
                    lclGrid_Data.update_Data_Cursor_X(new_Cursor_X_Int: lclCurrent_X_Bracket)
                }
            }
        }
    }
    
    func react_To_Swiper_X(x_OffsetParam: CGFloat) {
        //print("x_OffsetParam: ",x_OffsetParam.description,", dimz cell width: ",lclDimensions.gridUnitSize)
        let floatDivision = x_OffsetParam/lclDimensions.gridUnitSize
        let intDivision = Int(floatDivision)
        if current_X_Bracket != intDivision{
            current_X_Bracket = intDivision
        }
    }
    
    
}

//struct Respondeuse_View : View {
//    @ObservedObject var vslider_Responder_Store : V_Slider_Responder_Store
//    var body: some View {
//        return ZStack(alignment: .topLeading) {
//            VStack(alignment: .leading) {
//                Text(vslider_Responder_Store.currentLowVal.description).foregroundColor(.white)
//                Text(vslider_Responder_Store.currentHighVal.description).foregroundColor(.white)
//            }
//        }
//    }
//}

// im thinking that the way to do this is to only get the central grid to move up or down if the number is
// above 2 and below 29(lower midpoint and higher midpoint)
// so in a roll from 0 - 2 the cursor would simply descend from 0 to 2 without the grid moving
// then when it goes from 2(lower midpoint) to 3, the cursor stays in the same pos and the whole grid moves




//            lclCursor_Grid_Store.updateLineArrayPositions(currLowValParam: currentLowVal, currHighValParam: currentHighVal
//            , previousLowValParam: previousLowVal, previousHighValParam: previousHighVal)
