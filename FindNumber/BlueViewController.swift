//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Вадим Игнатенко on 21.01.22.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel

  
    }
    
    @IBAction func goToGreenController(_ sender: Any) {
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        if let vc =  storyboard.instantiateViewController(withIdentifier: "greenVC" ) as? GreenViewController {
            vc.textForLabel = "Text String"
            vc.title = "Зеленый"
            self.navigationController?.pushViewController(vc, animated: true)
        }
         
    }
    

    @IBOutlet weak var testLabel: UILabel!
    var textForLabel:String = ""

}
