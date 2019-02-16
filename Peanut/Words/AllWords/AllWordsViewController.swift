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
    lazy private var tableView = UITableView()
    private let wordStore: WordStore
    lazy private var searchBtn = UIButton()
    lazy private var sortBtn = UIButton()
    var words: [Word] {
        return wordStore.fetchWords(sortedBy: sortedType)
    }
    var sortedType: WordSortedType = .modified {
        didSet {
            guard oldValue != sortedType else { return }
            sortBtn.setImage(sortedType.icon, for: .normal)
            tableView.reloadData()
        }
    }
    
    init(wordStore: WordStore) {
        self.wordStore = wordStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implement init?")
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllWordCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(sortBtn)
        sortBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(12)
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
        }
        sortBtn.addTarget(self, action: #selector(sortBtnTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        sortedType = .char
    }
    
    @objc
    private func sortBtnTapped() {
        let alert = UIAlertController(title: "排序规则", message: "支持两种排序方法：1. 按首字母降序 2. 按修改时间降序", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: (sortedType == .char ? "保持" : "更改为") + "首字母降序",
                                      style: .default,
                                      handler: { [unowned self] _ in
                                         self.sortedType = .char
                                      }))
        alert.addAction(UIAlertAction(title: (sortedType == .modified ? "保持" : "更改为") + "修改时间降序",
                                      style: .default,
                                      handler: { [unowned self] _ in
                                        self.sortedType = .modified
                                     }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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

extension WordSortedType {
    var icon: UIImage? {
        switch self {
        case .char:
            return UIImage(named: "icon_sort_by_char")
        case .modified:
            return UIImage(named: "icon_sort_by_modified")
        }
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
