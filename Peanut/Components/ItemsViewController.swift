//
//  ItemsViewController.swift
//  Peanut
//
//  Created by 少 on 2018/12/9.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit

class ItemsViewController<Cell: UITableViewCell, Item>: UITableViewController {
    let configure: (Cell, Item) -> Void
    let items: [Item]
    var didSelectedItem: ((Item) -> Void)?

    init(items: [Item], configure: @escaping (Cell, Item) -> Void) {
        self.items = items
        self.configure = configure
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        configure(cell, items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectedItem?(items[indexPath.row])
    }
}

