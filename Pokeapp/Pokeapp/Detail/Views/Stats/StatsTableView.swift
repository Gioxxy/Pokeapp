//
//  StatsTableView.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import UIKit

class StatsTableView: UITableViewController {
    
    override func viewDidLoad() {
        tableView.register(StatTableViewCell.self, forCellReuseIdentifier: StatTableViewCell.cellId)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.rowHeight = 40
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.cellId, for: indexPath) as! StatTableViewCell
        return cell
    }
}
