//
//  LoginViewController.swift
//  SporApp
//
//  Created by Erkan on 15.03.2023.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var ziyaretciModu: UIButton!
    @IBOutlet weak var kayitOl: UIButton!
    @IBOutlet weak var girisYap: UIButton!
    @IBOutlet weak var txtParola: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        girisEkranLayout()
        

        
        
    }
    
    @IBAction func girisYapClicked(_ sender: Any) {
    }
    
    
    @IBAction func kayitOlClicked(_ sender: Any) {
    }
    
    @IBAction func ziyaretciClicked(_ sender: Any) {
    }
    
    
    private func girisEkranLayout(){
        txtEmail.autocapitalizationType = .none
        txtEmail.autocorrectionType = .no
        txtEmail.placeholder = "Email"
        txtParola.placeholder = "Parola"
        txtParola.isSecureTextEntry = true
        txtEmail.font = UIFont.boldSystemFont(ofSize: 16)
        txtParola.font = UIFont.boldSystemFont(ofSize: 16)
        kayitOl.layer.cornerRadius = 15
        girisYap.layer.cornerRadius = 15
        kayitOl.backgroundColor = .systemRed
        girisYap.backgroundColor = .systemRed
        kayitOl.tintColor = .white
        girisYap.tintColor = .white
        girisYap.setTitleColor(.white, for: .normal)
        ziyaretciModu.setTitleColor(.systemBlue, for: .normal)
    }

    

}
