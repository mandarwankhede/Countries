//
//  TableView+Enpty.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyContentMessage(message: String) {
        let emptyMsgLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyMsgLabel.text = message
        emptyMsgLabel.textAlignment = .center
        emptyMsgLabel.sizeToFit()
        self.backgroundView = emptyMsgLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
