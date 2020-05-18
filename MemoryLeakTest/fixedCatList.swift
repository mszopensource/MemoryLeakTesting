//
//  miniSocialMedia.swift
//  MemoryLeakTest
//
//  Created by Shunzhe Ma on 5/18/20.
//  Copyright © 2020 Shunzhe Ma. All rights reserved.
//

import Foundation
import UIKit

protocol catListActionDelegate: AnyObject {
    func moveCatUp(forCatNumber: Int)
    func moveCatDown(forCatNumber: Int)
}

class fixedCatList: UITableViewController, catListActionDelegate {
    
    var myCats = ["ネコノヒー",
                 "ムギ",
                 "レオ",
                 "ソラ",
                 "マル"
                 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Best Cats!"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fixedNaughtyCell") as! fixedNaughtyCell
        let row = indexPath.row
        let catName = myCats[row]
        cell.catNameLabel.text = catName
        cell.catID = row
        cell.delegate = self
        return cell
    }
    
    func moveCatUp(forCatNumber: Int) {
        if forCatNumber == 0 {
            //最高にお利口さんのネコがこちらです。しかしそうすると、配列の範囲外参照が起きてしまうのではないでしょうか。
            return
        }
        myCats.swapAt(forCatNumber, forCatNumber - 1)
        tableView.reloadData()
    }
    
    
    func moveCatDown(forCatNumber: Int) {
        if forCatNumber == (myCats.count - 1) {
            //宇宙で一番行儀が悪いネコ。しかしそうすると、配列の範囲外参照が起きてしまうのではないでしょうか。
            return
        }
        myCats.swapAt(forCatNumber, forCatNumber + 1)
        //ネコ「forCatNumber + 1」がもっと行儀悪くなりました！！！
        tableView.reloadData()
    }
    
}


class fixedNaughtyCell: UITableViewCell {
    
    @IBOutlet weak var catNameLabel: UILabel!
    
    /*
     もちろん、ネコの行儀の悪さは変化します。
     - 2つのボタンを設けてこれに対応します。
     -- 行儀悪さのランクをアップ
     -- 行儀悪さのランクをダウン
     */
    
    @IBAction func actionMoveUp(){
        delegate?.moveCatUp(forCatNumber: catID)
    }
    
    @IBAction func actionMoveDown(){
        delegate?.moveCatDown(forCatNumber: catID)
    }
    
    /*
     Fixed!
     */
    weak var delegate: catListActionDelegate?
    
    deinit {
        delegate = nil
    }
    
    /*
     また、どのネコのランクがアップまたはダウンしたのかがわかるように、ネコのIDを保存する変数を作ります...
     */
    var catID: Int!
    
}
