//: [Previous](@previous)
//: ### Guard Let Versus If Let
//: The following exercises will use `Card`, `User`, and the `checkout(withUser:forCharge:)` function.

struct Card {
    let token: String
    let brand: String
    let lastFourDigits: String
    let validCCV: Bool
}

class User {
    var cards = [String: Card]()
    var accountCredit: Double = 0.0
    
    init(cards: [String: Card], accountCredit: Double) {
        self.cards = cards
        self.accountCredit = accountCredit
    }
    
    func reduceCreditBy(_ amount: Double) {
        accountCredit -= amount
    }
}

func checkout(withUser user: User, forCharge charge: Double) {
    let cards = user.cards
    
    if cards.count > 0 {
        guard let card = cards["Personal Card"], card.validCCV, card.brand != "Discover" else {
            print("ERROR: must use Personal & non-Discover card; Business and Discover cards are not accepted")
            return
        }
        
        print("CHECKOUT: \(card.brand) \(card.lastFourDigits)")
    } else {
        guard user.accountCredit >= charge else {
            print("ERROR: \(charge) exceeds account credit \(user.accountCredit)")
            return
        }
        
        user.reduceCreditBy(charge)
        
        print("CHECKOUT: used account credit. remaining credit \(user.accountCredit)")
    }
}

let user1 = User(cards: [
    "Personal Card": Card(token: "token_00001", brand: "Visa", lastFourDigits: "0123", validCCV: true),
    "Business Card": Card(token: "token_00002", brand: "Mastercard", lastFourDigits: "9876", validCCV: true) // it prints CHECKOUT: Visa 0123 because there is "Personal Card" and non-Discover card
    ], accountCredit: 32.0)


let user2 = User(cards: [
    "Business Card": Card(token: "token_00003", brand: "Visa", lastFourDigits: "2222", validCCV: true) // becasuse "Business Card" it prints ERROR: ... String
    ], accountCredit: 1043.40)

let user3 = User(cards: [
    "Personal Card": Card(token: "token_00004", brand: "Discover", lastFourDigits: "4444", validCCV: true), // becasuse brand: "Discover" it prints ERROR: ... String
    "Business Card": Card(token: "token_00005", brand: "Mastercard", lastFourDigits: "5555", validCCV: true)
    ], accountCredit: 100.00)

let user4 = User(cards: [:], accountCredit: 10.20) // it executes else block because "if cards.count > 0" condition is not met. Note: when I comment out "Personal Card": ... validCCV: true)" and instead of this String just insert sign : for example in user3, for user3 it also executes else block.

let user5 = User(cards: [:], accountCredit: 100.00) // it executes else block because "if cards.count > 0" condition is not met.

//: - Callout(Exercise):
//: What will be printed when `checkout(withUser:forCharge:)` is invoked with `user1`, `user2`, `user3`, `user4`, or `user5`?

checkout(withUser: user1, forCharge: 100_000) // CHECKOUT: Visa 0123

checkout(withUser: user2, forCharge: 100_000) // ERROR: must use Personal & non-Discover card; Business and Discover cards are not accepted

checkout(withUser: user3, forCharge: 100_000) // ERROR: must use Personal & non-Discover card; Business and Discover cards are not accepted

checkout(withUser: user4, forCharge: 0.20) // CHECKOUT: used account credit. remaining credit 10.0

checkout(withUser: user5, forCharge: 1.0) // CHECKOUT: used account credit. remaining credit 99.0
         
         
