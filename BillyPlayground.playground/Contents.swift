import UIKit



extension Date {
    
    func asString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func monthAsString() -> String {
        let customFormat = "MM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


enum Months: String {
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
    
}

enum Frequency {
    case anual
    case semiAnual
    case quaterley
    case monthly
    case biweekly
    case weekly
    case none
}


class Bill {
    var name: String
    var amount: Double
    var dueDate: Date
    var notes: String?
    var isPaid: Bool
  //  var frequwncy: Frequency?
    
    init(name: String, amount: Double, dueDate: Date, notes: String?, isPaid: Bool){
        self.name = name
        self.amount = amount
        self.dueDate = dueDate
        self.notes = notes
        self.isPaid = isPaid
    }
}



class Month {
    var name: Months
    var bills: [Bill]
    
//    var bills: [Bill] {
//        get {
//        allTheBills.filter{ $0.dueDate.monthAsString() == name.rawValue }
//        }
//    }
    
    
    init(name: Months, bills: [Bill]){
        self.name = name
        self.bills = bills
    }
    
}

var allTheBills = [Bill]()



//do we wan to just add a whole year worth of bills
//or do we want to just add bills for that one year
//or do we want to have an end date and add bills till that end date

//for now im just going with adding bills for entire year - so if its june its gone add bills till june next year




func create(bill : Bill, frequency: Frequency){
    
    allTheBills.append(bill)
    
    let calendar = Calendar.current
    
    switch frequency {
    case .anual:
        print("anual")
    case .semiAnual:
        guard let newDate = calendar.date(byAdding: DateComponents(month: 6), to: bill.dueDate, wrappingComponents: false) else {return}
        let newBill = Bill(name: bill.name, amount: bill.amount, dueDate: newDate, notes: bill.notes, isPaid: false)
        allTheBills.append(newBill)
        
    case .quaterley:
        
        var monthsAmountToAdd = 3
        
        for _ in 0..<3{
            print(monthsAmountToAdd)
            guard let newDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: bill.dueDate, wrappingComponents: false) else {return}
            let newBill = Bill(name: bill.name, amount: bill.amount, dueDate: newDate, notes: bill.notes, isPaid: false)
            allTheBills.append(newBill)
            monthsAmountToAdd += 3
        }
        
    case .monthly:
        var monthsAmountToAdd = 1
        for _ in 0..<12{
            print(monthsAmountToAdd)
            guard let newDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: bill.dueDate, wrappingComponents: false) else {return}
            let newBill = Bill(name: bill.name, amount: bill.amount, dueDate: newDate, notes: bill.notes, isPaid: false)
            allTheBills.append(newBill)
            monthsAmountToAdd += 1
        }
        
        // add a month to the previous data leaving th day the samy - repeat remaining times for each month still remaining in the year - u
        
        print("monthly")
    case .biweekly:
        var daysToAdd = 14
        for _ in 0..<26{
            print(daysToAdd)
            
            guard let newDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: bill.dueDate, wrappingComponents: false) else {return}
            let newBill = Bill(name: bill.name, amount: bill.amount, dueDate: newDate, notes: bill.notes, isPaid: false)
            allTheBills.append(newBill)
            daysToAdd += 14
        }
        print("biweekly")
    case .weekly:
        var daysToAdd = 7
        for _ in 0..<52{
            print(daysToAdd)
            
            guard let newDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: bill.dueDate, wrappingComponents: false) else {return}
            let newBill = Bill(name: bill.name, amount: bill.amount, dueDate: newDate, notes: bill.notes, isPaid: false)
            allTheBills.append(newBill)
            daysToAdd += 7
        }
        print("weekly")
    case .none:
        print("none")
    }
    
}


var firstBill = Bill(name: "bill1", amount: 25.25, dueDate: Date().addingTimeInterval(2 * 86400), notes: "Heloo Hello", isPaid: false)


create(bill: firstBill, frequency: .biweekly)
allTheBills.count
print("bill 1 \(allTheBills[0].name), \(allTheBills[0].dueDate.asString()), \(allTheBills[0].isPaid)")
allTheBills[0].isPaid = true
print("bill 2 \(allTheBills[1].name), \(allTheBills[1].dueDate.asString()), \(allTheBills[1].isPaid)")
print("bill 1 \(allTheBills[0].name), \(allTheBills[0].dueDate.asString()), \(allTheBills[0].isPaid)")
allTheBills[0].isPaid = false
print("bill 2 \(allTheBills[1].name), \(allTheBills[1].dueDate.asString()), \(allTheBills[1].isPaid)")
print("bill 1 \(allTheBills[0].name), \(allTheBills[0].dueDate.asString()), \(allTheBills[0].isPaid)")
print("bill 2 \(allTheBills[1].name), \(allTheBills[1].dueDate.asString()), \(allTheBills[1].isPaid)")
print("last bill \(allTheBills.last!.name), \(allTheBills.last!.dueDate.asString()), \(allTheBills.last!.isPaid)")

//problem now it that the cill is a class and its a reference type so when i mark is paid it changes the second one
//fixed the problem - bill needs to be a struct - it needs to be copied not referenced




enum Months222{
    case january(Int, String)
    case february(Int, String)
    case march(Int, String)
    case april(Int, String)
    case may(Int, String)
    case june(Int, String)
    case july(Int, String)
    case august(Int, String)
    case september(Int, String)
    case october(Int, String)
    case november(Int, String)
    case december(Int, String)
    
}


let jan = Months222.january(01, "January")
