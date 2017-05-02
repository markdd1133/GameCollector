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
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func camera(_ sender: Any) {
        
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
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let game = Game(context: context)
        game.title = titleTextField.text
        game.image = UIImagePNGRepresentation(imageView.image!)! as NSData
        appDel.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}
