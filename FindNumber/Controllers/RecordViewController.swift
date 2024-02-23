//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Вадим Игнатенко on 27.01.22.
//

import UIKit


final class RecordViewController: UIViewController {

    // MARK: - properties
    
    private let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
    @IBOutlet private weak var recordLabel: UILabel!

    // MARK: - life cycle VC

    override func viewDidLoad() {
        super.viewDidLoad()
        stupUI()
    }
    
    // MARK: - methods

    @IBAction private func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func stupUI() {
        if record != 0 {
            recordLabel.text = "Ваш рекорд - \(record)"
        } else {
            recordLabel.text = "Рекорд не установлен"
        }
    }
}
