//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import UIKit
import WebKit

protocol CustomCellDelegate: class {
    func didUpdateObject(for cell: UITableViewCell)
}

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var flagWebView: WKWebView!
    
    private var observerContext = 0
    weak var delegate: CustomCellDelegate?
    var country: CountryModel? {
        willSet {
            country?.removeObserver(self, forKeyPath: #keyPath(CountryModel.flag), context: &observerContext)
        }
        didSet {
            countryName.text = country?.countryName
            flagWebView.loadHTMLString(country?.flag ?? "", baseURL: nil)
            country?.addObserver(self, forKeyPath: #keyPath(CountryModel.flag), context: &observerContext)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &observerContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        delegate?.didUpdateObject(for: self)
    }

    deinit {
        country?.removeObserver(self, forKeyPath: #keyPath(CountryModel.flag), context: &observerContext)
    }
}
