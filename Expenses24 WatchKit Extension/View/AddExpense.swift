//
//  AddExpense.swift
//  Expenses24
//
//  Created by jassak on 17/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI

struct AddExpense: View {
    @State var showAlert=false
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var passingData=PassingData()
    @State var category="Miscellaneous"
    var body: some View {
        GeometryReader {geo in
            List{
                Picker("Type of expense:",selection:$category){
                    ForEach(passingData.categories,id:\.self){item in
                        HStack() {
                            Image(systemName: item.icon).foregroundColor(.pink)
                                .frame(maxWidth:geo.size.width/7,alignment:.leading)
                            Text("\(item.name)").font(.footnote)
                        }.tag(item.name)
                    }
                }
                NavigationLink(
                    destination: AddView(passingData: passingData),
                    label: {
                        VStack(alignment:.leading) {
                            Text("Value:")
                            HStack{
                                Image(systemName: "\(passingData.currency)sign.circle").foregroundColor(.pink)
                                    .frame(maxWidth:geo.size.width/7,alignment:.leading)
                                Text("\(passingData.numEnter)")
                                    .foregroundColor(.gray)
                            }.font(.footnote)
                            
                        }
                    })
                Button(action:{
                    let entryData=Expense(context: moc)
                    entryData.date=Date()
                    //entryData.date=Calendar.current.date(byAdding: .day,value: -3, to: Date())
                    entryData.type=category
                    entryData.color=passingData.itemColor(category: category)
                    entryData.value=Double(passingData.numEnter) ?? 0
                    if moc.hasChanges{
                        do{
                            try moc.save()
                        }
                        catch{
                            print(error.localizedDescription)
                        }
                    }
                    passingData.numEnter=String()
                    showAlert=true
                }){
                    HStack{
                        Spacer()
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                }.listRowBackground(Color.pink.cornerRadius(10).opacity(passingData.numEnter.isEmpty ? 0.5 : 1)).disabled(passingData.numEnter.isEmpty)
            }.font(.headline)
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text("Expense added successfully"))
        }).onAppear(perform: {
            passingData.setDefaults()
        }).navigationBarTitle(Text("Add"))
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(passingData: PassingData())
    }
}

struct ArrayItems:Hashable{
    let name:String
    let icon:String
}
