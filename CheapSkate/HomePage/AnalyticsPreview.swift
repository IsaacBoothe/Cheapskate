//
//  AnalyticsPreview.swift
//  CheapSkate
//
//  Created by Isaac Boothe on 10/31/23.
//

import SwiftUI
import Charts

struct AnalyticsPreview: View {
    let data: [DataPoints] = [
        DataPoints(week: "week1", value: 1),
        DataPoints(week: "week2", value: 2),
        DataPoints(week: "week3", value: 3),
        DataPoints(week: "week4", value: 3),
        DataPoints(week: "week5", value: 4)
    ]
    var body: some View {
        Button {
            print("nav to analytics page")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(hex: "ededed"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    ).padding()
                    .frame(height: 160)
                
                VStack(alignment: .leading){
                    Text("Analytics")
                        .underline(true)
                        .padding(.vertical, 8)
                        .padding(.trailing, 10)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                    HStack {
                        Chart() {
                            ForEach(data) { dataPoint in
                                LineMark(
                                    x: .value("week", dataPoint.week),
                                    y: .value("value", dataPoint.value)
                                )
                            }.foregroundStyle(Color(hex: "005035"))
                        }.chartYAxis(.hidden)
                        .frame(width: 250, height: 80)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.forward.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(hex: "005035"))
                            .padding(.bottom, 30)
                    }.frame(width: 330)
                }
            }
        }
    }
}

struct DataPoints: Identifiable {
    let id = UUID()
    let week: String
    let value: Int
}

struct HomeAnalytics_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsPreview()
    }
}
