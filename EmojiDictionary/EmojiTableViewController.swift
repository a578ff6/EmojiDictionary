//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by 曹家瑋 on 2023/10/7.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    /// 用來存儲表格的數據
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",description: "A confused, puzzled face.", usage: "unsurewhat to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",description: "A smiley face with hearts for eyes.",usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer",description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software,programming"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
    ]
    
    
    // 用來定義 cell 的重用標識符（reuseIdentifier）
    struct PropertyKeys {
        static let emojiCell = "EmojiCell"
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置單元格的佈局邊距遵從螢幕的可讀寬度。
        // 而不是橫向填充整個表格視圖。有助於在較寬的螢幕（如iPad）上增強內容的可讀性。
        self.tableView.cellLayoutMarginsFollowReadableWidth = true
        
        // 用程式碼註冊一個 UITableViewCell 類型的單元格到表格視圖中，
        // 並設定其 reuseIdentifier 為 "EmojiCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: PropertyKeys.emojiCell)
        
        // 使用預定義的editButtonItem按鈕
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    // 每次視圖將要出現在螢幕上時都會被呼叫
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 通知表格視圖重新加載所有的數據
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    // 設置section（區段）
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    // 只有一個 Section
    }

    // 設置Row(行)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count      // 有多少 emoji 就有多少行
    }

    // 配置Cell(單元格)顯示數據
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 使用之前註冊的 reuseIdentifier ("EmojiCell") 來從表格視圖的一個可重用的單元格池中取出或創建一個單元格。
        // 取出單元格（Cell）
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.emojiCell, for: indexPath)
        // 取得模型對象
        let emoji = emojis[indexPath.row]
        // 配置單元格
        var content = cell.defaultContentConfiguration()
        content.text = "\(emoji.symbol) - \(emoji.name)"
        content.secondaryText = emoji.description
        cell.contentConfiguration = content             // 把配置好的內容設定給單元格（cell）
        
        // 顯示重新排列控制器
        cell.showsReorderControl = true
        
        // 回傳單元格
        return cell
    }
    
    // 確保表格處於編輯模式
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 從 data source 中移除被移動的單元格的數據。
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        // 將剛剛移除的單元格數據插入到新的位置。
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
    }

    

    // MARK: - Table view delegate
    
    // 響應用戶的選擇
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取得被選擇的 emoji
        let emoji = emojis[indexPath.row]
        
        // 輸出 emoji 符號和對應的索引路徑
        print("\(emoji.symbol) \(indexPath)")
    }
    
    // 為每個單元格(row)定義編輯樣式
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // 禁用刪除功能
        return .none
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
