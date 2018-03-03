//
//  main.swift
//  weather
//
//  Created by d182_raul_j on 03/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
UIApplicationMain(CommandLine.argc,
                  UnsafeMutableRawPointer(CommandLine.unsafeArgv)
                    .bindMemory(
                        to: UnsafeMutablePointer<Int8>.self,
                        capacity: Int(CommandLine.argc)),
                  NSStringFromClass(MyApplication.self),
                  NSStringFromClass(AppDelegate.self)
)
