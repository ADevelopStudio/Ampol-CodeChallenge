//
//  String+Ext.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

extension String {
    var localised: String { NSLocalizedString(self, comment: self) }
}

extension RawRepresentable where RawValue == String {
    var localised: String { self.rawValue.localised }
}
