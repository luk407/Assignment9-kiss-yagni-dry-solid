// 1. მოდით ჩვენს ხომალდს მივხედოთ SOLID Principle-ბის დაცვით. შევქმნათ Class-ი PirateShip⛴️🏴‍☠️, with properties: როგორციაა name, cannonsCount, crew👫 და cargo🍗🍖🥃🍺 Methods: firingCannons, adding/removing crew, adding/removing cargo.

protocol Cannons { // ISP
    func cannonCount()
    func fireCannon(_ count: Int)
}

class PirateShip: Cannons {
    let name: String
    var cannonsCount: Int
    private let cargoManager: CargoManaging // OCP
    private let crewManager: CrewManaging // OCP
    
    init(name: String, cannonsCount: Int, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.name = name
        self.cannonsCount = cannonsCount
        self.cargoManager = cargoManager
        self.crewManager = crewManager
    }
    
    func cannonCount() {
        print("Current number of cannons on this ship is: \(cannonsCount)")
    }
    
    func fireCannon(_ count: Int) {
        cannonsCount -= count
        print("\(name) has fired \(count) cannons!")
    }
    
}

protocol CargoManaging { // DIP
    func addCargo(_ newCargo: String)
    func removeCargo(_ cargoToRemove: String)
    func listCargo()
}

class CargoManager: CargoManaging { // SRP + DIP
    var cargo: [String]
    
    init(cargo: [String]) {
        self.cargo = cargo
    }
    
    func addCargo(_ newCargo: String) {
        cargo.append(newCargo)
    }
    
    func removeCargo(_ cargoToRemove: String) {
        cargo.removeAll { $0 == cargoToRemove }
    }
    
    func listCargo() {
        print("Here is a list of cargo on this ship:", terminator: " ")
        print(cargo.forEach { print($0, terminator: "; ") } ) // ზედმეტ ()-ს ბეჭდავს ბოლოში და ვერ გავასწორე :(
        print("")
    }
}

protocol CrewManaging { // DIP
    func addCrew(_ newCrew: String)
    func removeCrew(_ crewToRemove: String)
    func listCrew()
}

class CrewManager: CrewManaging { // SRP + DIP
    var crew: [String]
    
    init(crew: [String]) {
        self.crew = crew
    }
    
    func addCrew(_ newCrew: String) {
        crew.append(newCrew)
    }
    
    func removeCrew(_ crewToRemove: String) {
        crew.removeAll { $0 == crewToRemove }
    }
    
    func listCrew() {
        print("Here is a list of crew members on this ship:", terminator: " ")
        print(crew.forEach { print($0, terminator: "; ") })
        print("")
    }
}

class Frigate: PirateShip { // LSP
    var size: String
    
    init(name: String, cannonsCount: Int, cargoManager: CargoManager, crewManager: CrewManager, size: String) {
        self.size = size
        super.init(name: name, cannonsCount: cannonsCount, cargoManager: cargoManager, crewManager: crewManager)
    }
    
    func addCannons(_ count: Int) { // assignment-ის ბოლოში ეწერა საომრად გავამზადოთ გემიო და მაგისთვისაა დამატებული ეს ფუნქცია. მოცემულობაში არ იყო :)
        cannonsCount += count
        print("\(count) cannons has been added to \(name).\n")
    }
    
    override func cannonCount() {
        print("Current number of cannons on \(name) is: \(cannonsCount)\n")
    }
    
    override func fireCannon(_ count: Int) {
        cannonsCount -= count
        print("\(name) has fired \(count) cannons!\n")
    }
}

class Galleon: PirateShip { // LSP
    var size: String
    
    init(name: String, cannonsCount: Int, cargoManager: CargoManager, crewManager: CrewManager, size: String) {
        self.size = size
        super.init(name: name, cannonsCount: cannonsCount, cargoManager: cargoManager, crewManager: crewManager)
    }
    
    override func cannonCount() {
        print("Current number of cannons on \(name) is: \(cannonsCount)\n")
    }
    
    override func fireCannon(_ count: Int) {
        cannonsCount -= count
        print("\(name) has fired \(count) cannons!\n")
    }
}

// 2.TreasureMap KISS პრინციპის დაცვით. TreasureMap კლასი გვექნება ძალიან მარტივი ორი ფროფერთით: x და y ექნება. ერთი მეთოდი hintToTreasure, რომელიც მიიღებს x და y-ს და თუ ვიპოვეთ ჩვენი საგანძური დაგვიწერს ამას, თუ არასწორად მივუთითებთ კოორდინატებს მაშინ უნდა მოგვცეს hint-ი თუ საით უნდა წავიდეთ რომ მივაგნოთ საგანძურს.

class TreasureMap {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func hintToTreasure(destinationX: Int, destinationY: Int) {
        if destinationX > x {
            print("Hint: x coordinate must be lower than \(destinationX)!")
        } else if destinationX < x {
            print("Hint: x coordinate must be higher than \(destinationX)!")
        } else {
            print("x coordinate is found!")
        }
        
        if destinationY > y {
            print("Hint: y coordinate must be lower than \(destinationY)!")
        } else if destinationY < y {
            print("Hint: y coordinate must be higher than \(destinationY)!")
        } else {
            print("y coordinate is found!\n")
        }
        
        if destinationX == x && destinationY == y {
            print("Congratulations! You found a treasure.")
        }
        
        print("")
    }
}

// 3.SeaAdventure YAGNI პრინციპის დაცვით, პირატების მოგზაურობა თავგადასავლის გარეშე ვის გაუგია. შევქმნათ მარტივი SeaAdventure class-ი, ერთი String adventureType ფროფერთით და ერთი მეთოდით encounter რომელიც დაგვიბეჭდავს თუ რა adventure-ს წააწყდა ჩვენი ხომალდი. დავიცვათ YAGNI და არ დავამატოთ გავრცობილი ფუნქციონალი რომელიც სხვადასხვა adventure-ს შეიძლება მოიცავდეს, რომელიც ჯერ ჯერობით არ გვჭირდება.

class SeaAdventure {
    let adventureType: String
    
    init(adventureType: String) {
        self.adventureType = adventureType
    }
    
    func encounter() {
        print("Our ship encountered with \(adventureType) on their adventure.\n")
    }
}

// 4. PirateCode DRY პრინციპის დაცვით. შევქმნათ მარტივი კლასი PirateCode, რომელსაც ექნება ორი მეთოდი parley და mutiny, ამ მეთოდებში უნდა დავიწყოთ განხილვა მოლაპარაკებებზე წავალთ თუ ვიბრძოლებთ ეს კოდი რომ ორივე მეთოდში არ გაგვიმეორდეს დავიცვათ DRY პრინციპი და შევქმნათ ერთი private ფუნქცია discussTerms(term: String), რომელიც შეგვატყობინებს იმას რომ მოლაპარაკებები დაწყებულია, ხოლო parley და mutiny მოლაპარაკების შედეგს დაგვიბეჭდავენ.

class PirateCode {
    
    private func discussTerms(term: String) -> String {
        print("Negotiations has begun. The crew has to decide if they will accept the peace offer: \(term)")
        return term
    }
    
    func parley(term: String) {
        discussTerms(term: term)
        print("Crew has accepted the peace offer.\n")
    }
    
    func mutiny(term: String) {
        discussTerms(term: term)
        print("Crew has refused the peace offer.\n")
    }
}

// 5. დროა საგანძურის საძებნელად გავეშვათ. (Treasure hunting😄💰) შევქმნათ ჩვენი ხომალდი დავარქვათ სახელი, ეკიპაჟი დავამატოთ, საომრად გავამზადოთ, ავტვირთოთ cargo შევქმნათ ჩვენი საგანძულის კარტა და გადავაწდოთ კოორდინატები შევქმნათ პირატის კოდექსი რომელიც მოგზაურობისას დაგვეხმარება შევქმნათ SeaAdventure რომელსაც ჩვენი ეკიპაჟი შეიძლება გადააწყდეს, ამ შემთხვევაში ეს იქნება FlyingDutchman-თან გადაყრა.

let jackSparrow = CrewManager(crew: [])
let mrGibbs = CargoManager(cargo: [])
let blackPearl = Frigate(name: "Black Pearl", cannonsCount: 0, cargoManager: mrGibbs, crewManager: jackSparrow, size: "Small")

jackSparrow.addCrew("Pintel")
jackSparrow.addCrew("Ragetti")

blackPearl.addCannons(100)

mrGibbs.addCargo("Rum")

jackSparrow.listCrew()
mrGibbs.listCargo()

let maoKunMap = TreasureMap(x: 23, y: 56)

let pirataCodex = PirateCode()

let findDeadMansChest = SeaAdventure(adventureType: "Flying Dutchman")

var pearlX = 0
var pearlY = 0

maoKunMap.hintToTreasure(destinationX: 10, destinationY: 15)
maoKunMap.hintToTreasure(destinationX: 20, destinationY: 30)
maoKunMap.hintToTreasure(destinationX: 30, destinationY: 45)
maoKunMap.hintToTreasure(destinationX: 25, destinationY: 60)
maoKunMap.hintToTreasure(destinationX: 23, destinationY: 55)
maoKunMap.hintToTreasure(destinationX: 23, destinationY: 56)

findDeadMansChest.encounter()

pirataCodex.mutiny(term: "Jack Sparrow must serve on Flying Dutchman for 13 years!!!")

blackPearl.fireCannon(30)

blackPearl.cannonCount()

// cliffhanger-ზე დავასრულეთ მაგრამ სხვა გზა არ იყი :დ
