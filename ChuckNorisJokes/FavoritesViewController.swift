//
//  FavoritesViewController.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/18/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let topics: [String] = [
        "Chuck Norris doesn't read books. He stares them down until he gets the information he wants.",
        "Time waits for no man. Unless that man is Chuck Norris.",
        "If you spell Chuck Norris in Scrabble, you win. Forever.",
        "In the Beginning there was nothing ... then Chuck Norris roundhouse kicked nothing and told it to get a job.",
        "The dinosaurs looked at Chuck Norris the wrong way once. You know what happened to them.",
        """
        When God said, “Let there be light!” Chuck said, “Say Please."
        """,
        "Since 1940, the year Chuck Norris was born, roundhouse kick related deaths have increased 13,000 percent.",
        "Chuck Norris does not sleep. He waits.",
        "There is no chin behind Chuck Norris' beard. There is only another fist.",
        "Chuck Norris recently had the idea to sell his pee as a canned beverage. It’s now called Red Bull.",
        "If paper beats rock, rock beats scissors, and scissors beats paper, what beats all 3 at the same time? Chuck Norris.",
        "On the 7th day, God rested ... Chuck Norris took over."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        view.backgroundColor = .systemCyan
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: TableView
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = topics[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.backgroundColor = nil
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .brown
        cell.contentView.backgroundColor = .cyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item = MenuOptions.allCases[indexPath.row]
//        delegate?.didSelect(menuItem: item)
//    }
}
