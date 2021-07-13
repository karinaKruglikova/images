//
//  SecondViewController.swift
//  images
//
//  Created by Prome Theus on 9.07.21.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let items = ["https://auto.vercity.ru/img/magazine/old/30090.jpg","https://i.redd.it/3x67h7tirjj21.jpg","https://www.motortrend.com/uploads/sites/5/2020/11/2021-Infiniti-Q60-Red-Sport-400-8.jpg"]
    var imageVC: ImageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ImageViewController")
        
    }
}
extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        guard let opend = imageVC else {
            return }
        _ = opend.view
        
        DispatchQueue.global(qos: .background).sync {
            if let imageURL = URL(string: items[indexPath.row]) {
                if let imageData = try? Data(contentsOf: imageURL) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        
                        opend.imageView.image = image
                    }
                }
            }
        }
        navigationController?.show(opend, sender: nil)
    }
}
extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath)
        cell.textLabel?.text = "Машинка \(indexPath.row + 1)"
        
        return cell
    }
}
