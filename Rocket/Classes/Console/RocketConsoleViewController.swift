//
//  RocketConsoleViewController.swift
//  Rocket
//
//  Created by Mitch Treece on 10/19/17.
//

import UIKit
import SnapKit

public class RocketConsoleViewController: UIViewController {
        
    private var tableView: UITableView!
    
    private(set) var rocket: Rocket
    
    public static func instance(with rocket: Rocket = Rocket.shared) -> UIViewController {
        
        let vc = RocketConsoleViewController(rocket: rocket)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.barStyle = .blackTranslucent
        nav.navigationBar.barTintColor = UIColor.black
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        return nav
        
    }
    
    private init(rocket: Rocket) {
        
        self.rocket = rocket
        super.init(nibName: nil, bundle: nil)
        setup()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Please use RocketConsoleViewController.instance()")
    }
    
    private func setup() {
        
        self.title = "Console"
        view.backgroundColor = UIColor.black
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone(_:)))
        doneItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = doneItem
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        tableView.register(ConsoleEntryCell.self, forCellReuseIdentifier: ConsoleEntryCell.identifier)
        
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
            return
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension RocketConsoleViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocket.entries.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let entry = rocket.entries[indexPath.row]
        return ConsoleEntryCell.height(for: entry)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsoleEntryCell.identifier) as? ConsoleEntryCell
        cell?.entry = rocket.entries[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    
}
