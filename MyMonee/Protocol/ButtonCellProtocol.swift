//
//  ButtonCellProtocol.swift
//  MyMonee
//
//  Created by MacBook on 19/05/21.
//


import Foundation
import UIKit
protocol ButtonCellDelegate {
    func buttonCellDone(sender: UIButton)
    func buttonCellDelete(sender: UIButton)
}
