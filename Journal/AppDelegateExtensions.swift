//
//  AppDelegateExtensions.swift
//  FireBlog
//
//  Created by Nick Lee on 14/07/2017.
//  Copyright © 2017 nicklee. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    class var shared: AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    
}
