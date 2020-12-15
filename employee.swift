import Foundation

protocol Employee {
    var name: String {get set}
    var surname: String {get set}
    var salary: Double {get set}
    var dateOfBirth: String {get set}
    var dateOfEmploy: String? {get set}
}

protocol EmployeeHandler {
    func accept(_ worker: Worker)
    func fire(_ worker: Worker)
    func search(_ surname: String) -> Worker?
}

protocol WrongInputHandler {
    func checkDates(_ employ: String) -> String?
}

protocol SalaryCounter {
    func count() -> Double
    func countByPeriod(_ from: Date,_ to: Date) -> Double
}

extension Worker : SalaryCounter {
    
    func count() -> Double {
        var sal: Double
        switch self.typeOfWork {
        case .rate:
            sal = self.baseRate * self.experience
        case .hourly:
            sal = ((self.baseRate * (self.experience / 10)) * 8) * 20
        }
        
        return sal
    }
    
    func countByPeriod(_ from: Date, _ to: Date) -> Double {
        return count()
    }
    
}

struct Worker : Employee, WrongInputHandler {
    

    var name: String
    
    var surname: String
    
    let baseRate: Double = 200

    var salary: Double 
    
    var dateOfBirth: String
    
    var dateOfEmploy: String?
    
    var experience: Double
    
    var typeOfWork: WorkType
    
    init(_ name: String, _ surname: String,
         _ birth: String, _ employDate: String, _ exp: Double, _ type: WorkType = WorkType.rate) {
        
        self.name = name
        self.surname = surname
        dateOfBirth = birth
        experience = exp
        typeOfWork = type
        salary = baseRate
        dateOfEmploy = employDate
        salary = self.count()
        
    }
    
    internal func checkDates(_ employ: String) -> String? {
        var date: String? = nil
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDate: Date = dateFormatter.date(from: dateOfBirth)!
        let employDate: Date = dateFormatter.date(from: employ)!
        
        if employDate > birthDate {
            date = "none"
        } else {
            date = employ
        }
        
        return date
    
    }
    
    
}

enum WorkType {
    case rate, hourly
}

class EmployeeAccountig : EmployeeHandler {
  
    
    public var workers = [Worker]()
    
    func accept(_ worker: Worker) {
        workers.append(worker)
        print("Worker \(worker.surname) employed")
    }
    
    func fire(_ worker: Worker) {
        workers.remove(at: workers.index(where: { $0.surname == worker.surname})!)
        print("Worker \(worker.surname) fired")
    }
    
    func search(_ surname: String) -> Worker? {
        var employee: Worker? = nil
        
        for worker in workers {
            if worker.surname == surname {
                employee = worker
            }
        }
        
        return employee
    }
    
    func printAllEmployees(){
        for worker in workers {
            print("\(worker.name)  \(worker.surname)")
        }
    }
 
}

var accounting = EmployeeAccountig()

let viktor = Worker("Nata", "Na", "21.05.1982", "11.05.2014", 2, WorkType.rate)
let vitalik = Worker("Tony", "To", "14.05.1995", "11.10.2019", 1, WorkType.rate)
let masha = Worker("Andrew", "Andr", "14.05.1997", "12.09.2020", 3, WorkType.hourly)
let katya = Worker("Artem", "Tema", "14.05.1997", "09.08.2014", 4, WorkType.rate)

accounting.accept(nata)
accounting.accept(tony)
accounting.accept(andrew)
accounting.accept(artem)

accounting.printAllEmployees()

accounting.fire(artem)

accounting.printAllEmployees()

print(Andrew.salary)
print(Tony.salary)
