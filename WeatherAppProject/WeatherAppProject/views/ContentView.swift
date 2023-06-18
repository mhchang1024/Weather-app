//
//  ContentView.swift
//  WeatherAppProject
//
//  Created by Michael Chang on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location{
                if let weather = weather{
                    WeatherView(weather: weather)
                }else{
                  LoadingView()
                        .task{
                            do{
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            }catch{
                                print("Error getting weather: \(error)")
                            }
                        }
                }
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
