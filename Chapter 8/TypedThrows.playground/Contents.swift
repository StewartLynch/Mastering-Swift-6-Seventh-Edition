import Cocoa

enum PlayerNumberError: Error {
    case NumberTooHigh(description: String)
    case NumberTooLow(description: String)
    case NumberAlreadyAssigned
    case NumberDoesNotExist
}


typealias BaseballPlayer = (firstName: String, lastName: String, number: Int)


struct BaseballTeam {
    private let maxNumber = 99
    private let minNumber = 0
    private var players = [Int: BaseballPlayer]()
    
    mutating func addPlayer(player: BaseballPlayer) throws(PlayerNumberError) {
        guard player.number < maxNumber else {
            throw PlayerNumberError.NumberTooHigh(description: "Max number is \(maxNumber)")
        }
        guard player.number > minNumber else {
            throw PlayerNumberError.NumberTooLow(description: "Min number is \(minNumber)")
        }
        guard players[player.number] == nil else {
            throw PlayerNumberError.NumberAlreadyAssigned
        }
        players[player.number] = player
    }
    
    func getPlayerByNumber(number: Int) throws -> BaseballPlayer {
        if let player = players[number] {
            return player
        } else {
            throw PlayerNumberError.NumberDoesNotExist
        }
    }
    
}

func testBaseballPlayer() {
    var myTeam = BaseballTeam()

    do {
        try myTeam.addPlayer(player:("David", "Ortiz", 34))
        print("Player added")
    } catch PlayerNumberError.NumberTooHigh(let description) {
        print("Error: \(description)")
    } catch PlayerNumberError.NumberTooLow(let description) {
        print("Error: \(description)")
    } catch PlayerNumberError.NumberAlreadyAssigned {
        print("Error: Number already assigned")
    } catch {
        print("Error: Unknown Error")
    }
}

testBaseballPlayer()
