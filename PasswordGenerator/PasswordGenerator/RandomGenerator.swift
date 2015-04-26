import Foundation

private let characters = Array("0123456789qwertyuiopasdfghjklñzxcvbnmQWERTYUIOPASDFGHJKLÑZXCVBNM")

func generateRandomString(length: Int) -> String {
    var string = ""

    for index in 0..<length {
        string.append(generateRandomCharacter())
    }

    return string
}

func generateRandomCharacter() -> Character {
    let index = Int(arc4random_uniform(UInt32(characters.count)))

    let string = characters[index] as Character

    return string
}
