//
//  WeatherHomeView.swift
//  WeatherApp
//
//  Created by Deepthi Rao on 8/21/24.
//

import SwiftUI

struct WeatherHomeView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @ObservedObject var locationManager = WeatherLocationManager()
    @AppStorage("lastSavedLocationKey") var lastSavedLocation = ""
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        TextField("<Enter city to get weather info>", text: $searchText)
                            .font(.callout)
                            .foregroundColor(.purple)
                            .background(.white)
                        
                        Button(action: {
                            print("Search clicked")
                            viewModel.fetchWeatherReport(for: searchText)
                        }, label: {
                            Text("🔍")
                                .foregroundColor(.white)
                                .font(.footnote)
                        })
                        .frame(width: 21.0, height: 21.0, alignment: .center)
                        .padding(.horizontal)
                        .background(Color.white)
                    }
                    .padding([.leading, .trailing, .top], 40.0)
                    
                    if viewModel.model?.name.isEmpty == false {
                        List() {
                            // TODO: need to extract correct image dynamically by considering json response
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/10d@2x.png"))
                                .frame(width: 66.0, height: 66.0, alignment: .center)
                            
                            Text(lastSavedLocation)
                                .foregroundColor(.purple)
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .listRowSeparator(.hidden)
                            
                            Text("\(viewModel.temperature)°c")
                                .foregroundColor(.purple)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 66.0))

                            Text("\(viewModel.model?.weather[0].main ?? "")")
                                .foregroundColor(.purple)
                                .font(.system(size: 21.0))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .listRowSeparator(.hidden)

                            HStack {
                                Text("Low: \(viewModel.minTemperature)°c")
                                    .foregroundColor(.purple)
                                    .font(.system(size: 21.0))
                                Spacer()
                                Text("High: \(viewModel.maxTemperature)°c")
                                    .foregroundColor(.purple)
                                    .font(.system(size: 21.0))
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .padding()
                    }
                }
            }
            .navigationTitle("Weather")
            .onAppear(perform: {
                print("onAppear lastSavedLocation: \(lastSavedLocation)")
                if lastSavedLocation.isEmpty == false {
                    // fetch weather info by considering last saved location info
                    viewModel.fetchWeatherReport(for: lastSavedLocation)
                }
            })
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(title: Text("\(viewModel.showErrorMessage)"))
            })
        }
    }
}
