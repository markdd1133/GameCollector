//
//  ViewController.swift
//  GameCollector
//
//  Created by Sheng Chi Chen on 2017/5/3.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var games:[Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        do{
            games = try context.fetch(Game.fetchRequest())
            tableView.reloadData()
        }catch{
            let err = error as NSError
            print(err.debugDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let game = games[indexPath.row]
        cell.textLabel?.text = game.title
        cell.imageView?.image = UIImage(data: game.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! GameViewController
        nextVC.game = sender as? Game
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.persistentContainer.viewContext
            context.delete(games[indexPath.row])
            appDel.saveContext()
            do{
                games = try context.fetch(Game.fetchRequest())
                tableView.reloadData()
            }catch{
                let err = error as NSError
                print(err.debugDescription)
            }
        default:
            return
        }
    }
}

