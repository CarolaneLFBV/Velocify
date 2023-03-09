//
//  GaugeView.swift
//  Velocify
//
//  Created by Carolane LEFEBVRE on 08/03/2023.
//

import SwiftUI

struct GaugeView: View {
    @ObservedObject var locationManager = LocationManager()
    var speed: Double { return locationManager.speed }
    var speedAccuracy: Double { return locationManager.speedAccuracy }
    
    @State private var minSpeed = 0.0
    @State private var maxSpeed = 100.0
    
    let gradient = Gradient(colors: [.green, .orange, .red])

    var body: some View {
        Gauge(value: speed, in: minSpeed...maxSpeed) {
            Image(systemName: "kph")
        } currentValueLabel: {
            Text("\(Int(speed))")
        } minimumValueLabel: {
            Text(minSpeed.formatted(.number))
        } maximumValueLabel: {
            Text(maxSpeed.formatted(.number))
        }
        .gaugeStyle(.accessoryCircular)
        .scaleEffect(4.5)
        .tint(gradient)
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
    }
}
