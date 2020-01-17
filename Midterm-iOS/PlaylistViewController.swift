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
  
  let headerView: UIImageView = {
    let view = UIImageView()
    view.frame = CGRect(x: 0, y: 0, width: Constant.kScreenWidth, height: Constant.kScreenWidth)
    view.image = UIImage(named: "HeaderImage")
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    return view
  }()
  
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
    
    view.addSubview(headerView)
    
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
    
    tableView.contentInset = UIEdgeInsets(top: Constant.kScreenWidth, left: 0, bottom: 0, right: 0)
    
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.contentView.alpha = 0
    UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
      cell.contentView.alpha = 1
    }.startAnimation()
  }
  
}

extension PlaylistViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let y = Constant.kScreenWidth - (scrollView.contentOffset.y + Constant.kScreenWidth)
    let offset = Constant.kScreenWidth - y
    
    var height = CGFloat.zero
    
    if offset < 0 {
      height = max(y, Constant.kScreenWidth)
    } else {
      height = min(max(y, 0), Constant.kScreenWidth)
      headerView.alpha = y / Constant.kScreenWidth
    }
    
    headerView.frame = CGRect(x: 0, y: 0, width: Constant.kScreenWidth, height: height)
  }
 
}
