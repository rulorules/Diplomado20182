//
//  SettingsView.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/13/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    enum Keys: String {
        case darkTheme = "settingsDarkTheme"
    }
    let themeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dark Theme"
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let themeSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = false
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        print("asdf")
        setupLayout()
        loadDefaults()
    }
    
    func loadDefaults(){
        print("hpla")
        //themeSwitch.isOn = UserDefaults.standard.value(forKey: Keys.darkTheme.rawValue) as? Bool ?? false
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: Keys.darkTheme.rawValue)
        //Aqui no esta llegando

    }

    func setupLayout() {
        themeSwitch.addTarget(self, action: #selector(setThemeSetting), for: .valueChanged)
        addSubview(themeSwitch)
        NSLayoutConstraint.activate([
            themeSwitch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            themeSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        addSubview(themeLbl)
        NSLayoutConstraint.activate([
            themeLbl.bottomAnchor.constraint(equalTo: self.themeSwitch.topAnchor),
            themeLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            themeLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            themeLbl.heightAnchor.constraint(equalToConstant: 48)
        ])
        //Aqui si
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: Keys.darkTheme.rawValue)
    }

    @objc func setThemeSetting() {
        print("Theme Dark: \(self.themeSwitch.isOn)")
                UserDefaults.standard.set(self.themeSwitch.isOn,forKey: Keys.darkTheme.rawValue)
        
    }
}
