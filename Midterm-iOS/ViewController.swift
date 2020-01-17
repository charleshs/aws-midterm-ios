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
  let provider = PlaylistProvider()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let _ = AuthManager.shared.token else {
      AuthManager.shared.getToken { [weak self] result in
        switch result {
        case .success(let token):
          print(token.accessToken)
          self?.refreshPlaylist()
        case .failure(let error):
          print(error)
        }
      }
      return
    }
    
    refreshPlaylist()
    
  }
  
  func refreshPlaylist() {
    self.provider.fetchPlaylistFromStart { [weak self] result in
      switch result {
      case .success:
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
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
    return provider.playlist.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath)
    guard let songCell = cell as? SongTableViewCell else { return cell }
    
    songCell.titleLabel.text = provider.playlist[indexPath.row].name
    
    return songCell
  }
  
}

extension ViewController: UITableViewDelegate {
  
}
