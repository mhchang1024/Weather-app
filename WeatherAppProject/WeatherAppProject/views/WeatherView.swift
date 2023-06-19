//
//  WeatherView.swift
//  WeatherAppProject
//
//  Created by Michael Chang on 6/17/23.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment:.leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    /*Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)*/
                    TestView()
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                Spacer()
                
               
                VStack{
                    HStack{
                        VStack(spacing: 20) {
                            if weather.weather[0].description == "clear sky"{
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            } else if weather.weather[0].description == "few clouds"{
                                Image(systemName: "cloud.sun.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            }else if weather.weather[0].description == "fog"{
                                Image(systemName: "cloud.fog.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            }else if weather.weather[0].description == "scattered clouds"{
                                Image(systemName: "cloud")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            }else if weather.weather[0].description == "overcast clouds"{
                                Image(systemName: "smoke.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            } else if weather.weather[0].main == "Drizzle"{
                                Image(systemName: "cloud.drizzle.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].main)")
                            }else if weather.weather[0].description == "light rain"{
                                Image(systemName: "cloud.sun.rain.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            }else if weather.weather[0].description == "very heavy rain"{
                                Image(systemName: "cloud.rain.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            }else if weather.weather[0].description == "shower rain"{
                                Image(systemName: "cloud.heavyrain.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].description)")
                            }else if weather.weather[0].main == "Snow"{
                                Image(systemName: "snowflake")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].main)")
                            }else if weather.weather[0].main == "Thunderstorm"{
                                Image(systemName: "cloud.bolt.rain.fill")
                                    .font(.system(size: 40))
                                Text("\(weather.weather[0].main)")
                            }
                            
                            
                        }
                        .frame(width: 150, alignment: .leading)
                        Spacer()
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 90))
                            .fontWeight(.bold)
                            .padding()
                    }
                    Spacer()
                        .frame(height:  80)
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 350)
                                       } placeholder: {
                                           ProgressView()
                                       }
                                       
                    Spacer()
                }
                .frame(maxWidth: .infinity)

            }
            .padding()
            .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack{
                Spacer()
                VStack(alignment: .leading, spacing: 20){
                    Text("Weather Now")
                        .bold().padding(.bottom)
                    HStack{
                        let time = NSDate(timeIntervalSince1970: weather.sys.sunrise)
                        WeatherRow(logo: "sunrise", name: "SunSet", value: weather.sys.sunrise.roundDouble() + "am")
                        Spacer()
                        WeatherRow(logo: "sunset", name: "SunRise", value: ("\(time)") + " pm")
                        
                    }
                    HStack{
                        WeatherRow(logo: "thermometer.low", name: "Min Temp", value: weather.main.tempMin.roundDouble() + "°")
                        Spacer()
                        WeatherRow(logo: "thermometer.high", name: "Max Temp", value: weather.main.tempMax.roundDouble() + "°")
                        
                    }
                    HStack{
                        WeatherRow(logo: "wind.circle.fill", name: "Wind Speed ", value: weather.wind.speed.roundDouble() + "m/s")
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.589, saturation: 0.477, brightness: 0.46))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }

        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.589, saturation: 0.477, brightness: 0.46))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

struct TestView: View {
        @State var timeNow = ""
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var dateFormatter: DateFormatter {
                let fmtr = DateFormatter()
                fmtr.dateFormat = "LLLL dd, hh:mm:ss a"
                return fmtr
        }
        
        var body: some View {
                Text("Today, " + timeNow)
                        .onReceive(timer) { _ in
                                self.timeNow = dateFormatter.string(from: Date())
                        }
        }
}
