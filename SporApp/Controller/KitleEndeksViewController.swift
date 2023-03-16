//
//  KitleEndeksViewController.swift
//  SporApp
//
//  Created by Erkan on 16.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class KitleEndeksViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSonuc: UITextField!
    @IBOutlet weak var txtBoy: UITextField!
    @IBOutlet weak var txtKilo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    

    @IBAction func kaydetClicked(_ sender: Any) {
        
        guard let boy = Float(txtBoy.text ?? "0") else{return}
        guard let kilo = Float(txtKilo.text ?? "0") else{return}
        
        
        let vKitleEndex = kilo / ((boy/100)*(boy/100))
        print(kilo)
        print(boy)
        print(boy/100)
        
        txtSonuc.text = String(vKitleEndex)
        
        let eklenecekData = ["VücütKütleEndeksi": vKitleEndex]
        
        Firestore.firestore().collection("Kullanicilar").document(Auth.auth().currentUser!.uid).updateData(eklenecekData){ error in
            if let error = error{
                print("Vücut kitle eklenemedi \(error)")
            }
            print("Başarılı cnm")
            
        }
        
        
        
        
    }
    
    
    
}




