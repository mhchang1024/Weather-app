//
//  ContentView.swift
//  WeatherAppProject
//
//  Created by Michael Chang on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        VStack {
            if let location = locationManager.location{
                Text("Your coordinates are: \(location.longitude), \(location.latitude) ")
            }else{
                if locationManager.isLoading{
                    LoadingView()
                }else{
                    WelcomeView().environmentObject(locationManager)
                }
                
            }
            
        }
        .background(Color(hue: 0.589, saturation: 0.477, brightness: 0.46))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
