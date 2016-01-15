//: Playground - noun: a place where people can play
import Foundation

extension String {
    public func indexOfCharacter(char: Character) -> Int! {
        if let idx = self.characters.indexOf(char) {
            return self.startIndex.distanceTo(idx)
        }
        return -1
    }
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
}

let letters = "acdegilmnoprstuw"

func hash (s:String) -> Double {
    var h = 7
    for char in s.characters {
        h = (h * 37 + letters.indexOfCharacter(char))
    }
    return Double(h)
}

/*
Work below intentially left in
h0 = 7 * 37 + x8
h1 = h0 * 37 + x7
h1 = (7 * 37 + x8)*37 + x7
h2 = 7 * 37^3 + 37^2x8 + 37x7

h1 = 7* 37^2 + x1*37 + x2
h8 = 7*37^8 + x8*37^7 + x7*37^6 + x6*37^5 + x5*37^4  + x4*37^3 + x3*37^2  + x2*37^1  + x1
*/

/**
    Reverses the following hash function:
                
                func hash (s:String) -> Double {
                    var h = 7
                    for char in s.characters {
                        h = (h * 37 + letters.indexOfCharacter(char))
                    }
                    return Double(h)
                }

    Overall algorithm steps:
    1. Subtract the constant from the hash value
    2. figure out the characters index from left to right
    3. append the character of that index to the guess
    
    All bounds and input checking has been left out to keep the algorithm as clean as possible.

    The function can have the intitial seed value and the '37' constant passed in to remove all constants.

    - parameter hashVal: hash value to reverse the hash function.
    - parameter charLength: Hash output character length.
    - returns: String that generates hashVal when passed into hash().

*/
func reverseHash(hashVal: Double, charLength: Int) -> String {
    
    var currentGuess = ""
    var currentValue = hashVal - (7 * pow(Double(37),Double(charLength)))
    
    for power in 1...charLength {
        
        let multiplier:Double = pow(Double(37), Double(charLength - power))
        
        let indexVal = Int(floor(currentValue / multiplier))
        
        currentGuess = "\(currentGuess)\(letters[indexVal])"
        currentValue -= Double(indexVal) * multiplier

    }
    return currentGuess
}

var exampleString = "leepadg"

let hashVal = hash(exampleString)
let reversedString = reverseHash(hashVal, charLength: exampleString.characters.count)
print("Hashed unhashed matches: \(reversedString == exampleString)")

print("Hash for challenge(25377615533200): \(reverseHash(930846109532517, charLength: 9))")
