import Foundation

// TODO: - Clean this up

typealias SnackID = String

struct Snack {
    let id: String = UUID().uuidString
    let name: String
    let price: Int
}

let popcorn = Snack(name: "Popcorn", price: 4)
let skittles = Snack(name: "Skittles", price: 3)
let hotcheetos = Snack(name: "Hot Cheetos", price: 3)

var inventory: [SnackID: Snack] = [:]

[popcorn, skittles, hotcheetos].forEach { snack in
    inventory[snack.id] = snack
}

let id = hotcheetos.id

// check for key membership
if let snack = inventory[id] {
    print(snack)
}
guard let snack = inventory[id] else { fatalError() }
// at this point, item is populated


// check for key non-membership
if inventory[id] == nil {
    print("item does not exist")
}
guard inventory[id] == nil else { fatalError() }
// at this point, we know item doesn't exist
