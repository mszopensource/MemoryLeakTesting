//
//  miniSocialMedia.swift
//  MemoryLeakTest
//
//  Created by Shunzhe Ma on 5/18/20.
//  Copyright © 2020 Shunzhe Ma. All rights reserved.
//

import Foundation
import UIKit

class catList: UITableViewController {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "naughtyCell") as! naughtyCell
        let catName = myCats[indexPath.row]
        cell.catNameLabel.text = catName
        cell.catTableView = self
        cell.catID = indexPath.row
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


class naughtyCell: UITableViewCell {
    
    @IBOutlet weak var catNameLabel: UILabel!
    
    /*
     もちろん、ネコの行儀の悪さは変化します。
     - 2つのボタンを設けてこれに対応します。
     -- 行儀悪さのランクをアップ
     -- 行儀悪さのランクをダウン
     */
    
    @IBAction func actionMoveUp(){
        catTableView.moveCatUp(forCatNumber: catID)
    }
    
    @IBAction func actionMoveDown(){
        catTableView.moveCatDown(forCatNumber: catID)
    }
    
    /*
     そして、「catList」への参照を保存しなければなりません。なぜならネコの順番、そしてUITableViewCellsの表示順を変更したいからです。
     */
    var catTableView: catList!
    
    /*
     また、どのネコのランクがアップまたはダウンしたのかがわかるように、ネコのIDを保存する変数を作ります...
     */
    var catID: Int!
    
}
