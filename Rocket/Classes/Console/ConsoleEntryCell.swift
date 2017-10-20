//
//  ConsoleEntryCell.swift
//  Rocket
//
//  Created by Mitch Treece on 10/19/17.
//

import UIKit

class ConsoleEntryCell: UITableViewCell {
    
    static let identifier = "ConsoleEntryCell"
    private static let font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    private var label: UILabel!
    
    var entry: LogEntry? {
        didSet {
            guard let entry = entry else { return }
            layout(for: entry)
        }
    }
    
    static func height(for entry: LogEntry) -> CGFloat {
        
        guard let string = entry.consoleString else { return 0 }
        
        let size = CGSize(width: UIScreen.main.bounds.width - 16, height: CGFloat.greatestFiniteMagnitude)
        let textHeight = (string as NSString).boundingRect(with: size,
                                                           options: [.usesLineFragmentOrigin],
                                                           attributes: [NSAttributedStringKey.font: font],
                                                           context: nil).height
        
        let totalHeight = (8 + textHeight)
        return ceil(totalHeight)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        selectionStyle = .none
        
        label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = ConsoleEntryCell.font
        label.numberOfLines = 0
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(8)
            make.right.equalTo(-8)
            make.bottom.equalTo(0)
        }
        
    }
    
    private func layout(for entry: LogEntry) {
        
        label.text = entry.consoleString
        
    }
    
}
