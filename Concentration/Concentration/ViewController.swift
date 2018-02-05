
import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        
        return (cardButtons.count + 1) / 2
    }
    
    var emojiChoices = String()
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // MARK: Handle touch behaviour
    @IBAction func touchCard(_ sender: UIButton) {
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
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        indexOfTheme = randomIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        indexOfTheme = randomIndex
       
    }
    
    private func updateViewFromModel() {
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private struct Theme {
        var name: String
        var emojis: String
    }
    
    private var emojiThemes: [Theme] = [
        Theme(name: "animals", emojis: "🐶🐻🐼🐯🦁🐮🐷🐵🐴🦉🦋"),
        Theme(name: "fruits", emojis: "🍎🍐🍋🍌🍉🍇🍓🍈🍒🥝"),
        Theme(name: "nature", emojis: "🌲☘️🌼🌞🌱🌹🎋🍄🌵🌺"),
        Theme(name: "balls", emojis: "⚽️🏀🏈⚾️🎾🏐🏉🎱"),
        Theme(name: "sports", emojis: "⛷🏂🏋🏿‍♂️🏌🏾‍♂️🏄🏻‍♂️🚣🏻‍♂️🏊‍♀️🤽🏼‍♀️🧘🏻‍♂️⛹🏿‍♀️"),
        Theme(name: "transportation", emojis: "✈️🚗🚕🚜🛵🏍🚲🚌🚅🛳🚁")
    ]
    
    private var indexOfTheme = 0 {
        didSet {
            emoji = [Card: String]()
            emojiChoices = emojiThemes[indexOfTheme].emojis
        }
    }
    
    private  var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}














































































