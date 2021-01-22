//
//  StatsTableView.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import UIKit

final class StatsTableView: UITableViewController {
    
    private var stats: [StatsViewModel]?
    
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
    
    func config(stats: [StatsViewModel]){
        self.stats = stats
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stats?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let stats = stats {
            let cell = tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.cellId, for: indexPath) as! StatTableViewCell
            cell.config(stat: stats[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
