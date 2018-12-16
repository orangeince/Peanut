//
//  SettingsViewController.swift
//  Peanut
//
//  Created by 少 on 2018/12/15.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    enum SettingItem: String {
        case theme = "Theme"
        
        case api = "API configure"
        case sync = "Sync from iCloud"
        case clean = "Clean up"
        
        case about = "About peanut"
        case mail = "Mail to supporter"
    }
    
    enum Section: CaseIterable {
        case general([SettingItem])
        case data([SettingItem])
        case other([SettingItem])
        
        public static var allCases: [Section] {
            return [
                .general([.theme]),
                .data([.api, .sync, .clean]),
                .other([.about, .mail])
            ]
        }
    }
    var tableView: UITableView!
    let sections: [Section] = Section.allCases

    func setupSubviews() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.backgroundColor = UIColor(244)
        tableView.separatorColor = UIColor(244)
        tableView.register(SettingItemCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        setupSubviews()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 60
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .general: return "General"
        case .data: return "Data"
        case .other: return "App"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController.Section: Collection {
    typealias Element = SettingsViewController.SettingItem
    var items: [Element] {
        switch self {
        case .general(let rows):
            return rows
        case .data(let rows):
            return rows
        case .other(let rows):
            return rows
        }
    }
    
    func index(after i: Int) -> Int {
        return items.index(after: i)
    }
    
    subscript(position: Int) -> SettingsViewController.SettingItem {
        return items[position]
    }
    
    var startIndex: Int {
        return items.startIndex
    }
    
    var endIndex: Int {
        return items.endIndex
    }
    
    func makeIterator() -> IndexingIterator<([Element])> {
        return items.makeIterator()
    }
}
