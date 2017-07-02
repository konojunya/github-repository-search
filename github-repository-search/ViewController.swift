//
//  ViewController.swift
//  github-repository-search
//
//  Created by konojunya on 2017/07/02.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - outlet
    @IBOutlet weak var sortPickerView: UIPickerView!
    @IBOutlet weak var orderPickerView: UIPickerView!
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let sortList = ["","stars","forks","updated"]
    let orderList = ["desc","asc"]
    let disposeBag = DisposeBag()
    var repositories = GitHubRepositories()
    var searchText = ""
    var sortText = ""
    var orderText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate settings
        self.repositoriesTableView.delegate = self
        self.repositoriesTableView.dataSource = self
        self.sortPickerView.delegate = self
        self.sortPickerView.dataSource = self
        self.sortPickerView.tag = 1
        self.orderPickerView.delegate = self
        self.orderPickerView.dataSource = self
        self.orderPickerView.tag = 2
        
        self.searchBar.rx.text.orEmpty
            .throttle(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(
                onNext: { [unowned self] q in
                    self.searchText = q
                    self.searchRepository()
                },
                onError: { err in
                    print(err)
                },
                onCompleted: {
                    print("completed")
                }
            )
            .addDisposableTo(self.disposeBag)
        
    }
    
    func searchRepository(){
        let request = FetchRepositoriesRequest(query: self.searchText, sort: self.sortText, order: self.orderText)
        Session.rx_response(request: request)
            .subscribe(
                onNext: { GitHubRepositories in
                    self.repositories = GitHubRepositories
                },
                onError: { err in
                    print(err)
                },
                onCompleted: {
                    self.repositoriesTableView.reloadData()
                }
            )
            .addDisposableTo(self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // tableView delegate method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.repositories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath)
        
        return cell
        
    }
    
    //MARK: - pickerview delegate method
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return self.sortList.count
        } else {
            return self.orderList.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return self.sortList[row]
        } else {
            return self.orderList[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.sortText = self.sortList[row]
        } else {
            self.orderText = self.orderList[row]
        }
        self.searchRepository()
    }

}

