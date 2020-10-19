//
//  RocketLaunchRow.swift
//  iosApp
//
//  Created by sunny on 10/20/20.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared

struct RocketLaunchRow: View {
    var rocketLaunch: RocketLaunch

       var body: some View {
           HStack() {
               VStack(alignment: .leading, spacing: 10.0) {
                   Text("Launch name: \(rocketLaunch.missionName)")
                   Text(launchText).foregroundColor(launchColor)
                   Text("Launch year: \(String(rocketLaunch.launchYear))")
                   Text("Launch details: \(rocketLaunch.details ?? "")")
               }
               Spacer()
           }
       }
}

extension RocketLaunchRow {
   private var launchText: String {
       if let isSuccess = rocketLaunch.launchSuccess {
           return isSuccess.boolValue ? "Successful" : "Unsuccessful"
       } else {
           return "No data"
       }
   }

   private var launchColor: Color {
       if let isSuccess = rocketLaunch.launchSuccess {
           return isSuccess.boolValue ? Color.green : Color.red
       } else {
           return Color.gray
       }
   }
}

struct RocketLaunchRow_Previews: PreviewProvider {
    static var previews: some View {
        RocketLaunchRow()
    }
}
