//
//  ViewController.swift
//  Deeplinks
//
//  Created by Syed Qamar Abbas on 28/04/2020.
//  Copyright © 2020 Syed Qamar Abbas. All rights reserved.
//

import UIKit

class Deeplink: NSObject {
    var link: String = ""
    var title: String = ""
    
    init(_ object: Any) {
        if let dict = object as? [String: Any] {
            if let value = dict["link"] as? String {
                self.link = value
            }
            if let value = dict["title"] as? String {
                self.title = value
            }
        }
        if let value = object as? String {
            link = value
            title = "Deeplink"
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var deeplinkSchemeTFHeight: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    var scheme: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "deeplink_scheme")
        }
        get{
            return UserDefaults.standard.string(forKey: "deeplink_scheme") ?? ""
        }
    }
    var prevSelectedIndex: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "prevSelectedIndex")
        }
        get{
            return UserDefaults.standard.integer(forKey: "prevSelectedIndex")
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    var deeplinks = [Deeplink]()
    var allDeeplinks = [Deeplink]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(didChangeSearchText), for: .editingChanged)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.keyboardDismissMode = .onDrag
        loadData()
        updateViews()
        // Do any additional setup after loading the view.
    }
    func loadData() {
        if segmentControl.selectedSegmentIndex == 0 {
            loadData(withKey: "deeplinks")
        }else {
            loadData(withKey: "branch_links")
        }
        self.tableView.reloadData()
    }
    func loadData(withKey: String) {
        if let url = Bundle.main.url(forResource: "deeplink", withExtension: "json") {
            if let data = try? Data.init(contentsOf: url) {
                if let dictObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    if let deeplinkList = dictObj[withKey] as? [Any] {
                        self.allDeeplinks = []
                        for obj in deeplinkList {
                            let deep = Deeplink(obj)
                            self.allDeeplinks.append(deep)
                        }
                        self.deeplinks = self.allDeeplinks
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            if self.scheme.count == 0 {
                return 0
            }
        }
        return deeplinks.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        let d = deeplinks[indexPath.row]
        var deeplink = d.link
        if segmentControl.selectedSegmentIndex == 0 {
            deeplink = "\(scheme)://\(d.link)"
        }
        cell.textLabel?.text = d.title
        cell.detailTextLabel?.text = deeplink
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        if indexPath.row == self.prevSelectedIndex {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            cell.textLabel?.textColor = UIColor.darkGray;
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            cell.detailTextLabel?.textColor = UIColor.darkGray;
        }else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            cell.textLabel?.textColor = UIColor.lightGray;
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            cell.detailTextLabel?.textColor = UIColor.lightGray;
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.prevSelectedIndex = indexPath.row
        let d = deeplinks[indexPath.row]
        var deeplink = d.link
        if segmentControl.selectedSegmentIndex == 0 {
            deeplink = "\(scheme)://\(d.link)"
        }
        if let url = URL(string: deeplink) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        tableView.reloadData()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
            if self.scheme.count > 0 {
                self.scheme.removeLast()
                updateViews()
            }
            return false
        }
        self.scheme = "\(self.scheme)\(string)"
        updateViews()
        return false
    }
    @objc func didChangeSearchText() {
        if let text = self.searchTextField.text, !text.isEmpty {
            let filteredDeeplinks = self.allDeeplinks.filter { (deep) -> Bool in
                if deep.title.lowercased().contains(text) {
                    return true
                }
                if deep.link.lowercased().contains(text) {
                    return true
                }
                return false
            }
            self.deeplinks = filteredDeeplinks
            self.tableView.reloadData()
        }else {
            self.deeplinks = allDeeplinks
            self.tableView.reloadData()
        }
    }
    func updateViews () {
        if self.scheme.count > 0 {
            textField.text = "\(self.scheme)://"
        }else {
            textField.text = ""
        }
        
        tableView.reloadData()
    }
    @IBAction func didChangeSegmentControl(_ sender: Any) {
        viewChanged()
    }
    func viewChanged() {
        if segmentControl.selectedSegmentIndex == 0 {
            self.deeplinkSchemeTFHeight.constant = 34;
        }else {
            self.deeplinkSchemeTFHeight.constant = 0;
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            self.loadData()
        }
    }
}

