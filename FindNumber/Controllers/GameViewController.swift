//
//  GameViewController.swift
//  FindNumber
//
//  Created by Вадим Игнатенко on 18.01.22.
//

import UIKit


class GameViewController: UIViewController {
    
    // MARK: - properties
   
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    
    // MARK: - life cycle VC

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    // MARK: - methods

    @IBAction private func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index:buttonIndex)
        updateUI()
    }
    

    @IBAction private func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    
    private func setupScreen() {
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons [index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        updateInfoGame(with: game.status)
    }
    
    
    private func updateInfoGame (with status:StatusGame) {
        switch  status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Ты победитель"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord {
                showAlert ()
            } else {
                showAlertActionSheet ()
            }
        case .lose:
            statusLabel.text = "Ты проиграл лузер"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet ()
        }
    }
    
    
    private func showAlert () {
        let alert = UIAlertController (title: "Поздравляем", message: "Ты стал лучшим в этой фантастической игре!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showAlertActionSheet () {
        let alert = UIAlertController (title: "Каие пожелания?", message:  nil, preferredStyle: .actionSheet)
        let newGameAction = UIAlertAction (title: "Новая игра", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        let showRecord = UIAlertAction(title: "Посмотреть рекорд", style: .default) { [weak self] (_) in
        self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        let menuAction = UIAlertAction (title: "Перейти в меню", style: .destructive) { [weak self](_) in
        self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        if let popover = popoverPresentationController {
            popover.sourceView = statusLabel
        }
        present(alert,animated: true, completion: nil)
    }
}
