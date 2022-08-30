//: [Previous](@previous)
//: ### Guards with Optionals
//: - Callout(Exercise):

struct Card {
    let token: String
    let brand: String
    let lastFourDigits: String
    let validCCV: Bool
}

func checkout(card: Card?) {
    guard let card = card, card.validCCV, card.brand != "Discover" else { return }
    
    print("CHECKOUT: \(card.brand) \(card.lastFourDigits)")
}

let testCard = Card(token: "token1234", brand: "Visa", lastFourDigits: "0123", validCCV: true)

//: If `checkout(card:)` is invoked using `testCard`, will it exit early?

checkout(card: testCard)

//: it will not exit early, instead it will print out: "CHECKOUT: Visa 0123"
//: YES, correct it works. 

//: [Next](@next)
