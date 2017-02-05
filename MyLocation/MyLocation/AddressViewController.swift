//
//  AddressViewController.swift
//  MyLocation
//
//  Created by elahiammar on 9/3/16.
//  Copyright © 2016 elahiammar. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressTextField.delegate = self
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.addressTextField.resignFirstResponder()
        return true;
        
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard let text = self.addressTextField.text, !text.isEmpty else {
            // Show Empty TextField Alert
            let alertController = UIAlertController.init(title: "Alert!", message: "Address field can not be empty", preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return false
 
        }
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationSegue"{
            let locationViewController = segue.destination as! LocationViewController
            locationViewController.addressString = self.addressTextField.text
        }
    }
}
