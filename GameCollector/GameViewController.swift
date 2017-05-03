//
//  GameViewController.swift
//  GameCollector
//
//  Created by Sheng Chi Chen on 2017/5/3.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addUpdate: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var game:Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if game != nil{
            imageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            addUpdate.setTitle("Update", for: .normal)
        }else{
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func camera(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photos(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIButton) {
        if game != nil{
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(imageView.image!) as NSData?
        }else{
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.persistentContainer.viewContext
            let game = Game(context: context)
            game.title = titleTextField.text
            game.image = UIImagePNGRepresentation(imageView.image!) as NSData?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
}
