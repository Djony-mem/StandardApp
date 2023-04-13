//
//  ModuleBilder.swift
//  StandardApp
//
//  Created by brubru on 29.11.2022.
//

import UIKit

protocol Assemblying {

    /// Собрать MVP-модуль
    /// - Parameter viewController: UIVIewController компонуемого модуля
    func configur(viewController: UIViewController)
}

