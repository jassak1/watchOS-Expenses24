//
//  ListView.swift
//  Expenses24
//
//  Created by jassak on 18/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var passingData:PassingData
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]) var coreObject1:FetchedResults<Expense>
    var body: some View {
        VStack {
            List(){
                ForEach(passingData.dictionaryObject(coreObject:coreObject1).sorted(by: {$0.0>$1.0}),id:\.key){key in
                    Section(header:Text("\(passingData.listDate(date: key.value[0].myDate))")){
                        ForEach(key.value,id:\.self){value in
                            HStack(spacing:10) {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("\(value.myColor)"))
                                    .frame(maxWidth:5)
                                    .padding(.vertical,2)
                                VStack(alignment:.leading) {
                                    Text("\(value.myType)")
                                        .font(.headline)
                                    Text("\(passingData.currencyList[passingData.currency] ?? "dollar") \(String(format:"%g",value.value))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }.onDelete{offset in
                            removeEntry(object: key.value, row: offset)
                        }
                    }
                }
            }.onAppear(perform: {
                passingData.setDefaults()
            }).navigationBarTitle(Text("List"))
        }
    }
    
    func removeEntry(object: [Expense], row: IndexSet) {
        for i in row{
            moc.delete(object[i])
        }
        if moc.hasChanges{
            do{
                try moc.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(passingData: PassingData())
    }
}
