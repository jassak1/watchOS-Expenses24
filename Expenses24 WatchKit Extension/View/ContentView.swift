//
//  ContentView.swift
//  Expenses24
//
//  Created by jassak on 17/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var moc = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    var body: some View {
        GeometryReader{geo in
            VStack(spacing:5) {
                HStack {
                    NavigationLink(
                        destination: AddExpense().environment(\.managedObjectContext, moc),
                        label: {
                            ContentItem(geo: geo,imageColor: Color.red,imageName: "plus",description: "Add")
                        }).buttonStyle(PlainButtonStyle())
                    Spacer()
                    NavigationLink(
                        destination: ListView(passingData: AddExpense().passingData).environment(\.managedObjectContext, moc),
                        label: {
                            ContentItem(geo: geo,imageColor: Color.blue,imageName: "list.bullet",description: "List")
                        }).buttonStyle(PlainButtonStyle())
                }.padding(.top,1)
                HStack {
                    NavigationLink(
                        destination: BudgetView(passingData: AddExpense().passingData).environment(\.managedObjectContext, moc),
                        label: {
                            ContentItem(geo: geo,imageColor: Color.green,imageName: "chart.pie",description: "Budget")
                        }).buttonStyle(PlainButtonStyle())
                        
                    Spacer()
                    NavigationLink(
                        destination: SettingsView(passingData: AddExpense().passingData),
                        label: {
                            ContentItem(geo: geo,imageColor: Color.purple,imageName: "gear",description: "Settings")
                        }).buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentItem: View {
    var geo:GeometryProxy
    var imageColor:Color
    var imageName:String
    var description:String
    var body: some View {
        VStack(spacing:5){
            Image(systemName: imageName)
                .foregroundColor(imageColor)
                .font(.title)
                .frame(width: geo.size.width/3, height: geo.size.height/3)
                .background(Color.black)
                .clipShape(Circle())
                .shadow(color: Color.gray, radius: 5, x: 0.5, y: 0.5)
            Text(description)
                .font(.footnote)
                .fontWeight(.semibold)
        }.frame(width: geo.size.width/2, height: geo.size.height/2)
    }
}
