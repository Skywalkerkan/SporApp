//
//  RegisterViewController.swift
//  SporApp
//
//  Created by Erkan on 15.03.2023.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtKullaniciAdi: UITextField!
    @IBOutlet weak var kayitOl: UIButton!
    @IBOutlet weak var txtParolaTekrar: UITextField!
    @IBOutlet weak var txtParola: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerLayout()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilFoto))
        view.addGestureRecognizer(gestureRecognizer)
        
        

        

        
        
       
    }
    
    @objc func profilFoto(){
        let alert = UIAlertController(title: "Fotoğraf", message: "Lütfen fotoğrafı seçmek istediğiniz şeyi seçin", preferredStyle: .actionSheet)
        let actionCam = UIAlertAction(title: "Kamera", style: .default){_ in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        let actionMedia = UIAlertAction(title: "Galeri", style: .default) { _ in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        alert.addAction(actionCam)
        alert.addAction(actionMedia)
        present(alert, animated: true)
    }
    
    
    private func registerLayout(){
        txtKullaniciAdi.placeholder = "Kullanıcı Adı"
        txtKullaniciAdi.font = UIFont.boldSystemFont(ofSize: 15)
        txtEmail.placeholder = "Email"
        txtEmail.font = UIFont.boldSystemFont(ofSize: 15)
        txtParola.placeholder = "Parola"
        txtParola.font = UIFont.boldSystemFont(ofSize: 15)
        txtParolaTekrar.placeholder = "Parola tekrar"
        txtParolaTekrar.font = UIFont.boldSystemFont(ofSize: 15)
        txtParola.isSecureTextEntry = true
        txtParolaTekrar.isSecureTextEntry = true
        kayitOl.layer.cornerRadius = 15
        kayitOl.tintColor = .white
        kayitOl.backgroundColor = .systemRed
    }
    
    @IBAction func kayitOlClicked(_ sender: Any) {
        print("kayit ol tiklandi")
        guard let kullaniciAdi = txtKullaniciAdi.text else{return}
        guard let email = txtEmail.text else{return}
        guard let parola = txtParola.text else{return}
        guard let parolatekrar = txtParolaTekrar.text else{return}
        if parola != parolatekrar{
            let alert = UIAlertController(title: "Parola", message: "Parolanızın aynı olması gerekmektedir.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(actionOK)
            present(alert, animated: true)
        }else{
            Auth.auth().createUser(withEmail: email, password: parola) { result, error in
                if let error = error{
                    print(error.localizedDescription)
                }
                
                guard let kaydolanKullaniciId = result?.user.uid else{return}
                let goruntuAdi = UUID().uuidString
                let referans = Storage.storage().reference(withPath: "/ProfilFotoğraflari/\(goruntuAdi)")
                let goruntuData = self.imageView.image?.jpegData(compressionQuality: 0.6) ?? Data()
                referans.putData(goruntuData, metadata: nil) { _, error in
                    if let error = error{
                        print("\(error) Data yuklenırken hata oluştu")
                        return
                    }
                    print("Başarıyla yüklendi")
                    
                    referans.downloadURL { url, error in
                        if let error = error{
                            print("Image Yüklenemedi \(error)")
                        }
                        
                        print("Upload edilen URL: \(url?.absoluteString ?? "")")
                        
                        let eklenecekData = ["KullaniciAdi": kullaniciAdi,
                                             "KullaniciID": kaydolanKullaniciId,
                                             "ProfilGoruntuURL": url?.absoluteString ?? ""
                        ]
                        
                        Firestore.firestore().collection("Kullanicilar").document(kaydolanKullaniciId).setData(eklenecekData){ error in
                            if let error = error{
                                print("Kolleksiyonlanamadı \(error)")
                            }
                            print("Başarılı bir şekilde koleksiyon oluşturuldu")
                            
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyBoard.instantiateViewController(withIdentifier: "vucutKitleVC")
                            viewController.modalPresentationStyle = .fullScreen
                            self.present(viewController, animated: true)
                            
                        }
                        
                    }
                    
                }
            }
        }
    }
    
}


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageChosen = info[.editedImage] as? UIImage
        self.imageView.image = imageChosen?.withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.red.cgColor
        dismiss(animated: true)
    }
    
}
