//
//  ViewController.swift
//  SearchBarExercise
//
//  Created by Yan Wu on 5/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,
UITableViewDataSource,UITableViewDelegate {
    
    // 引用通过storyboard创建的控件
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var tableView : UITableView!
    
    // 所有组件
    var ctrls:[String] = ["Label","Button1","Button2","Switch"]
    // 搜索匹配的结果，Table View使用这个数组作为datasource
    var ctrlsel:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 起始加载全部内容
        self.ctrlsel = self.ctrls
        //设置代理
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // 注册TableViewCell
        self.tableView.registerClass(UITableViewCell.self,
                                     forCellReuseIdentifier: "SwiftCell")
    }
    
    // 返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrlsel.count
    }
    
    // 创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        // 同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify,
                                                               forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = self.ctrlsel[indexPath.row]
        return cell
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText == "" {
            self.ctrlsel = self.ctrls
        }
        else { // 匹配用户输入内容的前缀(不区分大小写)
            self.ctrlsel = []
            for ctrl in self.ctrls {
                if ctrl.lowercaseString.hasPrefix(searchText.lowercaseString) {
                    self.ctrlsel.append(ctrl)
                }
            }
        }
        // 刷新Table View显示
        self.tableView.reloadData()
    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
     searchBar.resignFirstResponder()
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
