//
//  AddView.swift
//  Expenses24
//
//  Created by jassak on 17/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var hideView
    @State var showAlert=false
    @ObservedObject var passingData:PassingData
    var body: some View {
        GeometryReader{geo in
            VStack(spacing:5) {
                HStack {
                    Text("\(passingData.currencyList[passingData.currency] ?? "dollar") \(passingData.numEnter)")
                        .font(.title)
                    
                    Spacer()
                    Button(action:{
                        if (passingData.numEnter.hasSuffix(".") || passingData.numEnter == "0") || (passingData.numEnter.starts(with:"0") && !passingData.numEnter.contains(".")){
                            showAlert=true
                        }else{
                            hideView.wrappedValue.dismiss()
                        }
                    }){
                        Text("OK").font(.headline).frame(width: geo.size.width/4, height: geo.size.height/4)
                            .background(Color.pink).cornerRadius(10)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.horizontal,5).padding(.bottom,10)
                HStack() {
                    ForEach(1..<4){num in
                        VStack(spacing:5) {
                            Button(action:{
                                passingData.numEnter=passingData.numEnter+String(num)
                            }){
                                SubText(geo:geo,inputText: "\(num)")
                            }.buttonStyle(PlainButtonStyle())
                            Button(action:{
                                passingData.numEnter=passingData.numEnter+String(num+3)
                            }){
                                SubText(geo:geo,inputText: "\(num+3)")
                            }.buttonStyle(PlainButtonStyle())
                            Button(action:{
                                passingData.numEnter=passingData.numEnter+String(num+6)
                            }){
                                SubText(geo:geo,inputText: "\(num+6)")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                HStack {
                    Button(action:{
                        if (!passingData.numEnter.contains(".")){
                            passingData.numEnter=passingData.numEnter+"."
                        }
                        if (passingData.numEnter.starts(with: ".")){
                            passingData.numEnter="0."
                        }
                    }){
                        SubText(bgColor:Color("LightGray"),geo:geo,inputText: ".")
                    }.buttonStyle(PlainButtonStyle())
                    Button(action:{
                        passingData.numEnter=passingData.numEnter+"0"
                    }){
                        SubText(geo:geo,inputText: "0")
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action:{
                        if (!passingData.numEnter.isEmpty){
                            passingData.numEnter.removeLast()
                        }
                    }){
                        Image(systemName: "delete.left")
                            .frame(width: geo.size.width/3.2, height: geo.size.height/7)
                            .background(Color("LightGray")).cornerRadius(5)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }.onDisappear(perform: {
            if (!isValidNum()){
                passingData.numEnter=String()
            }
        }).alert(isPresented: $showAlert, content: {
            Alert(title: Text("Please enter valid number"))
        })
    }
    
    func isValidNum()->Bool{
        if (passingData.numEnter.hasSuffix(".") || passingData.numEnter == "0") || (passingData.numEnter.starts(with:"0") && !passingData.numEnter.contains(".")){
            return false
        }else{
            return true
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(passingData: PassingData())
    }
}

struct SubText: View {
    var bgColor:Color=Color("DarkGray")
    var geo:GeometryProxy
    var inputText:String
    var body: some View {
        Text("\(inputText)")
            .frame(width: geo.size.width/3.2, height: geo.size.height/7)
            .background(bgColor).cornerRadius(5)
    }
}
