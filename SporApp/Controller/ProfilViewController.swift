//
//  ProfilViewController.swift
//  SporApp
//
//  Created by Erkan on 16.03.2023.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import SDWebImage

class ProfilViewController: UIViewController {

    @IBOutlet weak var lblDurum: UILabel!
    @IBOutlet weak var lblEndeks: UILabel!
    @IBOutlet weak var lblKullaniciAdi: UILabel!
    @IBOutlet weak var profilImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutDuzenle()
        DispatchQueue.main.async {
            self.verileriGetir()
        }
       
    }
    

    private func layoutDuzenle(){
        profilImage.layer.cornerRadius = profilImage.frame.width / 2
        profilImage.layer.masksToBounds = false
        profilImage.clipsToBounds = true
        profilImage.layer.borderWidth = 2.5
        profilImage.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func verileriGetir(){
        print("tamam")
        let db = Firestore.firestore()
        let kullaniciID = Auth.auth().currentUser?.uid
        let collectionRef = db.collection("Kullanicilar").document(kullaniciID ?? "")
        
        collectionRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {return}
            guard let kullaniciAdi = data["KullaniciAdi"] else {return}
            guard let kitleEndeks: Float = data["VücütKütleEndeksi"] as? Float else {return}
            guard let url = data["ProfilGoruntuURL"] as? String else {return}
            
            let ref = Database.database().reference()
            let storageRef = Storage.storage().reference(forURL: url)
           // self.profilImage.sd_setImage(with: storageRef)
            let fileRef = storageRef.child(url)
            //print(fileRef)
            let urlSon = URL(string: url)
            //print(urlSon)
            self.profilImage.sd_setImage(with: urlSon)
            
            
            /*fileRef.getData(maxSize: 5*1024*1024) { data, error in
                if error == nil && data != nil{
                    print("giriyor")
                    if let image = UIImage(data: data!){
                        
                        
                        DispatchQueue.main.async {
                            self.profilImage.image = image
                            print("Oldu bu iş")
                        }
                    }
                }
            }*/
            
            
            self.lblKullaniciAdi.text = "\(kullaniciAdi)"
            self.lblEndeks.text = String(format: "%.2f", kitleEndeks)
            
        }
    }
    
    

}
