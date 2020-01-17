//
//  ViewController.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {
  
  var songViewModels = [SongViewModel]()
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      setupTableView()
    }
  }
  
  private func appendViewModels(_ songs: [Song]) {
    songs.forEach { song in
      songViewModels.append(
        SongViewModel(songTitle: song.name, imageUrlString: song.album.images[0].url)
      )
    }
  }
  
  private let provider = PlaylistProvider()
  
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
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    let nib = UINib(nibName: SongTableViewCell.identifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
    let bannerFrame = CGRect(x: 0,
                             y: 0,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.width)
    tableView.tableHeaderView = BannerView(frame: bannerFrame, image: UIImage(named: "BannerImage"))
    implementPagination()
  }
  
  private func refreshPlaylist() {
    
    songViewModels.removeAll()
    
    self.provider.fetchPlaylistFromStart { [weak self] result in
      switch result {
      case .success(let songs):
        
        self?.appendViewModels(songs)
        
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func implementPagination() {
    tableView.addRefreshFooter {
      self.provider.fetchPlaylistNextPage { [weak self, hasNextPage = self.provider.hasNextPage] result in
        switch result {
        case .success(let songs):
          self?.appendViewModels(songs)
          DispatchQueue.main.async {
            self?.tableView.reloadData()
            if hasNextPage {
              self?.tableView.endFooterRefreshing()
            } else {
              self?.tableView.endWithNoMoreData()
            }
          }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
}

extension PlaylistViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return songViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath)
    
    guard let songCell = cell as? SongTableViewCell else { return cell }
    
    songCell.layoutCell(with: songViewModels[indexPath.row])
    
    return songCell
  }
  
}

extension PlaylistViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.contentView.alpha = 0
    UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
      cell.contentView.alpha = 1
    }.startAnimation()
  }
  
}

extension PlaylistViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    <#code#>
  }
}
