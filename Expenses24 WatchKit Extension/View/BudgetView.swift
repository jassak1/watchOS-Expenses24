//
//  BudgetView.swift
//  Expenses24
//
//  Created by jassak on 19/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI
import CoreData

struct BudgetView: View {
    @State var showSheet=false
    @ObservedObject var passingData:PassingData
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]) var coreObject1:FetchedResults<Expense>
    @Environment(\.managedObjectContext) var moc
    @State var selection=0
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.5)
                    .foregroundColor(.pink)
                    .padding()
                Circle()
                    .trim(from: 0.0, to: CGFloat((1-passingData.dailyCount(inDictionary: passingData.dictionaryObject(coreObject: coreObject1), day: selection).0/passingData.budget)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .opacity(0.7)
                    .foregroundColor(.pink)
                    .rotationEffect(Angle(degrees: 270))
                    .padding()
                VStack {
                    Text("Equity")
                    Text("\(passingData.currencyList[passingData.currency] ?? "dollar") \(String(format:"%g",passingData.budget-passingData.dailyCount(inDictionary: passingData.dictionaryObject(coreObject: coreObject1), day: selection).0))").foregroundColor(.gray)
                }.font(.headline).onLongPressGesture {
                    showSheet=true
                }
                
            }.animation(.linear).sheet(isPresented: $showSheet, content: {
               /* ForEach(passingData.dailyCount(inDictionary: passingData.dictionaryObject(coreObject: coreObject1), day: selection).2,id:\.key){key in
                    Text("\(key.key)")
                }*/
            })
            HStack{
                if (passingData.dictionaryCount(inDictionary: passingData.dictionaryObject(coreObject: coreObject1), selection: selection)).1{
                    Image(systemName: "chevron.compact.left")}
                Text("\(passingData.dailyCount(inDictionary: passingData.dictionaryObject(coreObject: coreObject1), day: selection).1)")
                if (passingData.dictionaryCount(inDictionary: passingData.dictionaryObject(coreObject: coreObject1), selection: selection)).2{
                    Image(systemName: "chevron.compact.right")}
            }.padding(.top,10)
        }.edgesIgnoringSafeArea(.bottom).gesture(DragGesture().onEnded{
            if ($0.startLocation.x > $0.location.x){
                if (selection<(passingData.dictionaryObject(coreObject:coreObject1).sorted(by: {$0.0>$1.0})).count-1){
                    selection+=1
                }
            }
            else if ($0.startLocation.x < $0.location.x && selection>0){
                selection=selection-1
            }
        }).onAppear(perform: {
            passingData.setDefaults()
        }).navigationBarTitle(Text("Budget"))
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView(passingData: PassingData())
    }
}

