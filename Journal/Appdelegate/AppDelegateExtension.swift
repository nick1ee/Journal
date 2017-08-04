//
//  AppDelegateExtension.swift
//  FireBlog
//
//  Created by Nick Lee on 14/07/2017.
//  Copyright © 2017 nicklee. All rights reserved.
//

import UIKit

//swiftlint:disable force_cast
extension AppDelegate {

    class var shared: AppDelegate {

        return UIApplication.shared.delegate as! AppDelegate

    }

}
//swiftlint:enable force_cast
