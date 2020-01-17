//
//  ViewController.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      setupTableView()
    }
  }
  
  let auth = AuthManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    auth.getToken { (result) in
      switch result {
      case .success(let token):
        print(token.accessToken)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func setupTableView() {
    
    tableView.dataSource = self
    tableView.delegate = self
    
    let nib = UINib(nibName: SongTableViewCell.identifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
    
    let bannerFrame = CGRect(x: 0,
                             y: 0,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.width)
    
    tableView.tableHeaderView = BannerView(frame: bannerFrame, image: UIImage(named: "BannerImage"))
  }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath)
    guard let songCell = cell as? SongTableViewCell else { return cell }
    
    songCell.titleLabel.text = "Row \(indexPath.row)"
    
    return songCell
  }
  
}

extension ViewController: UITableViewDelegate {
  
}
