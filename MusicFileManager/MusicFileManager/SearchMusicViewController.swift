//
//  SearchMusicViewController.swift
//  MusicFileManager
//
//  Created by Daulet Mussabayev on 4/30/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import UIKit

class SearchMusicViewController: UIViewController {

    var tracks: [Track] = []
    
    var currentPath: String?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textField.delegate = self
        
        let ok = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(search))
        navigationItem.rightBarButtonItems = [ok]
        
        MusicService.shared.searchForMusic(title:"") { [weak self] result, error in
                guard let self = self else { return }
                
                if let tracks = result?.tracks {
                    self.tracks = tracks
                    self.tableView.reloadData()
                } else if let error = error {
                    print(error)
                }
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
        
    @objc private func search(){
        guard let title = textField.text else { return }
        MusicService.shared.searchForMusic(title:title) { [weak self] result, error in
            guard let self = self else { return }
            
            if let tracks = result?.tracks {
                self.tracks = tracks
                self.tableView.reloadData()
            } else if let error = error {
                print(error)
            }
        }
        textField.text = ""
    }
        
    

    }



extension SearchMusicViewController: TrackTableViewCellDelegate {
    func didPressPlay(track: Track) {
        MusicService.shared.play(track: track)
    }
    
    func didPressDownload(track: Track, completion: @escaping (Track) -> ()) {
        guard let path = self.currentPath else { return }
        MusicService.shared.download( cur_path: path, track: track) { url, error in
            if let url = url {
                completion(track)
            } else if let error = error {
                print(error)
            }
        }
    }
}

extension SearchMusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath) as! MusicViewCell
        cell.track = self.tracks[indexPath.row]
        cell.delegate = self
        
        
        return cell
    }
}
extension SearchMusicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
