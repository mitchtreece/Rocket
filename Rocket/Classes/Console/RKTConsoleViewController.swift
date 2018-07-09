//
//  RKTConsoleViewController.swift
//  Rocket
//
//  Created by Mitch Treece on 10/19/17.
//

import UIKit
import SnapKit

/**
 A debug console view controller used to view `Rocket` logs.
 */
public class RKTConsoleViewController: UINavigationController {
    
    /**
     The console view controller for the shared `Rocket` instance.
     */
    public static var shared: RKTConsoleViewController {
        return RKTConsoleViewController(rocket: Rocket.shared)
    }
    
    /**
     Initializes a new console view controller for a `Rocket` instance.
     */
    public init(rocket: Rocket) {
        
        super.init(nibName: nil, bundle: nil)
        
        let vc = _RKTConsoleViewController(rocket: rocket)
        self.setViewControllers([vc], animated: false)
        
        self.navigationBar.barStyle = .blackTranslucent
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

internal class _RKTConsoleViewController: UIViewController {
        
    private var tableView: UITableView!
    private var rocket: Rocket
    
    init(rocket: Rocket) {
        
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
        
        tableView.register(ConsoleEventCell.self, forCellReuseIdentifier: ConsoleEventCell.identifier)
        
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
            return
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension _RKTConsoleViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocket.logEvents.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let entry = rocket.logEvents[indexPath.row]
        return ConsoleEventCell.height(for: entry)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsoleEventCell.identifier) as? ConsoleEventCell
        cell?.event = rocket.logEvents[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    
}
