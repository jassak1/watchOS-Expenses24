//
//  PassingDataVM.swift
//  Expenses24
//
//  Created by jassak on 22/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI
import CoreData

class PassingData: ObservableObject {
    let currencyList=["dollar":"$","lira":"£","euro":"€"]
    @Published var currency:String="dollar"{
        didSet{
            UserDefaults.standard.setValue(currency, forKey: "currency")
        }
        
    }
    @Published var budget:Double=100{
        didSet{
            UserDefaults.standard.setValue(budget, forKey: "budget")
        }
    }
    @Published var numEnter=String()
    let categories:[ArrayItems]=[ArrayItems(name: "Miscellaneous", icon: "dollarsign.circle"),ArrayItems(name: "Housing", icon: "house"),ArrayItems(name: "Groceries", icon: "leaf.arrow.circlepath"),ArrayItems(name: "Utilities", icon: "lightbulb"),ArrayItems(name: "Transportation", icon: "tram.fill"),ArrayItems(name: "Health-Care", icon: "waveform.path.ecg"),ArrayItems(name: "Personal-Care", icon: "heart"),ArrayItems(name: "Restaurants", icon: "house")]
    
    func itemColor(category:String)->String{
        switch category {
        case "Miscellaneous":
            return "MiscBG"
        case "Housing":
            return "HousBG"
        case "Groceries":
            return "GroceBG"
        case "Utilities":
            return "UtiliBG"
        case "Transportation":
            return "TranspoBG"
        case "Health-Care":
            return "HealthBG"
        case "Personal-Care":
            return "PersonalBG"
        case "Restaurants":
            return "RestauBG"
        default:
            return "MiscBG"
        }
    }
    
    func dictionaryObject(coreObject:FetchedResults<Expense>)->[String:[Expense]]{
        var coreDictionary:[String:[Expense]]{
            Dictionary(grouping: coreObject, by: {coreDate(date: $0.myDate)})
        }
        return coreDictionary
    }
    
    func coreDate(date:Date) -> String {
        let formatter=DateFormatter()
        formatter.dateStyle = .short
        return (formatter.string(from: date))
    }
    func listDate(date:Date) -> String {
        let formatter=DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return (formatter.string(from: date))
    }
    
    func dictionaryCount(inDictionary:[String:[Expense]],selection:Int)->(Int,Bool,Bool){
        let keyCount = inDictionary.count-1
        if (keyCount>0){
            if selection==0 {
                return (keyCount,false,true)
            }
            else if (selection>0 && selection < keyCount){
                return(keyCount,true,true)
            }
            else if (selection==keyCount){
                return (keyCount,true,false)
            }
            else {
                return (keyCount,true, true)
            }
        }
        else{
            return (keyCount,false,false)
   
        }

    }
    
    func dailyCount(inDictionary:[String:[Expense]],day:Int)->(Double,String){
        var date=String()
        var value=Double()
        
        for (index,element) in inDictionary.sorted(by:{$0.0>$1.0}).enumerated(){
            if index==day{
                for item in element.value{
                    value+=item.value
                }
                date=element.key
                break
            }
        }
        return (value,date)
    }
            
    func setDefaults() {
        guard let currencyInit = UserDefaults.standard.string(forKey: "currency") else {
            currency="dollar"
            return
        }
        currency=currencyInit
        let budgetInit = UserDefaults.standard.double(forKey: "budget")
        guard budgetInit > 0 else{
            budget = 100
            return
        }
        budget = budgetInit
    }
}

