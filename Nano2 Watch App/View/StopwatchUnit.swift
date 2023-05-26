//
//  StopwatchUnit.swift
//  Nano2 Watch App
//
//  Created by Geraldy Kumara on 21/05/23.
//

import SwiftUI

struct StopwatchUnit: View {
    var timeUnit: Int
    
    var timeUnitString: String {
        let timeUnitString = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitString : timeUnitString
    }
    
    var body: some View {
        VStack{
            HStack(spacing: 2) {
                Text(timeUnitString.substring(index: 0))
                    .font(.system(size: 12))
                Text(timeUnitString.substring(index: 1))
                    .font(.system(size: 12))
            }
        }
    }
}

struct StopwatchUnit_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchUnit(timeUnit: 0)
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}
