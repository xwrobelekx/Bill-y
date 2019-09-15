//
//  SelfSizedTableView.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/20/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit


class SelfSizedTableView: UITableView {
    
    
    //MARK: - Reload Data
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    
    //MARK: - Settings
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
