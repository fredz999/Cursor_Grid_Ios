//
//  P_VSlider_Responder.swift
//  Pattern_Grid_Ios_Proj_2
//
//  Created by Jon on 04/05/2022.
//

import Foundation
import SwiftUI
import Combine
protocol P_VSlider_Responder{
    func react_To_Swiper_Y(y_OffsetParam: CGFloat)
}
