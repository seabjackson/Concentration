
import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = [String]()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    // MARK: Handle touch behaviour
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.reset()
        updateViewFromModel()
        flipCount = 0
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        indexOfTheme = randomIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        indexOfTheme = randomIndex
       
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 0) : #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            }
        }
    }
    
    private struct Theme {
        var name: String
        var emojis: [String]
    }
    
    private var emojiThemes: [Theme] = [
        Theme(name: "animals", emojis: ["🐶", "🐻", "🐼", "🐯", "🦁", "🐮", "🐷", "🐵", "🐴", "🦉", "🦋"]),
        Theme(name: "fruits", emojis: ["🍎", "🍐", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🥝"]),
        Theme(name: "nature", emojis: ["🌲", "☘️", "🌼", "🌞", "🌱", "🌹", "🎋", "🍄", "🌵", "🌺"]),
        Theme(name: "balls", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"]),
        Theme(name: "sports", emojis: ["⛷", "🏂", "🏋🏿‍♂️", "🏌🏾‍♂️", "🏄🏻‍♂️", "🚣🏻‍♂️", "🏊‍♀️", "🤽🏼‍♀️", "🧘🏻‍♂️", "⛹🏿‍♀️"]),
        Theme(name: "transportation", emojis: ["✈️", "🚗", "🚕", "🚜", "🛵", "🏍", "🚲", "🚌", "🚅", "🛳", "🚁"])
    ]
    
    private var indexOfTheme = 0 {
        didSet {
            emoji = [Int: String]()
            emojiChoices = emojiThemes[indexOfTheme].emojis
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}






