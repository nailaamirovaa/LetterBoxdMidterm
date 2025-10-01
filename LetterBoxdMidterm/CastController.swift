//
//  CastController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 29.09.25.
//

import UIKit

class CastController : UIViewController
{
    @IBOutlet weak var table: UITableView!
    
    var cast = [Cast]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cast"

        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "CastControllerCell", bundle: nil), forCellReuseIdentifier: "CastControllerCell")
    }

}


extension CastController : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastControllerCell") as! CastControllerCell
        cell.configureCell(image: cast[indexPath.row].image, text: cast[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/10
    }
    
}
