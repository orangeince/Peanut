//
//  AllWordsViewController.swift
//  Peanut
//
//  Created by 少 on 2019/2/14.
//  Copyright © 2019 ShaoZ. All rights reserved.
//

import UIKit
import SnapKit

class AllWordsViewController: UIViewController {
    private var tableView = UITableView()
    private let wordStore: WordStore
    var words: [Word] {
        return wordStore.words
    }
    
    init(wordStore: WordStore) {
        self.wordStore = wordStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implement init?")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllWordCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension AllWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllWordCell
        let word = words[indexPath.row]
        cell.setup(content: word.content)
        return cell
    }
}

class AllWordCell: UITableViewCell {
    private var cardBg: UIView!
    private var contentLabel: UILabel!
    private var dateLabel: UILabel!
    private var detailBtn: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        selectionStyle = .none
    }
    
    private func setupSubviews() {
        backgroundColor = .clear
        cardBg = UIView()
        cardBg.backgroundColor = .white
        addSubview(cardBg)
        cardBg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        }
        cardBg.layer.cornerRadius = 8
        cardBg.clipsToBounds = true
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 22)
        contentLabel.textColor = .black
        cardBg.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

//        dateLabel = UILabel()
//        dateLabel.font = UIFont.systemFont(ofSize: 12)
//        dateLabel.textColor = UIColor.lightGray
//        cardBg.addSubview(dateLabel)
//        dateLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(contentLabel.snp.leading)
//            make.top.equalTo(contentLabel.snp.bottom).offset(4)
//        }
//
//        detailBtn = UIButton()
//        detailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        detailBtn.backgroundColor = .lightGray
//        detailBtn.layer.cornerRadius = 12
//        detailBtn.clipsToBounds = true
//        cardBg.addSubview(detailBtn)
//        detailBtn.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(12)
//            make.height.equalTo(24)
//            make.width.equalTo(44)
//        }
//        detailBtn.setTitle("释义", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(content: String) {
        contentLabel.text = content
    }
}
