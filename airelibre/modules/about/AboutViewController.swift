//
//  HomeViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-10.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var tvSeeProject: UILabel!
    @IBOutlet weak var tvLicense: UILabel!
    @IBOutlet weak var tvCreator: UILabel!
    @IBOutlet weak var tvIconApp: UILabel!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnWeb: UIButton!
    
    private let linkColorDark = UIColor.init("176EFF")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelClicks()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        themeApp()
        configureUI()
    }
    
    private func configureUI(){
        if(isDarkTheme()){
            self.tvSeeProject.textColor = linkColorDark
            self.tvLicense.textColor = linkColorDark
            self.tvCreator.textColor = linkColorDark
            self.tvIconApp.textColor = linkColorDark
        }
    }
        
    @IBAction func onClickTwitter(_ sender: Any) {
        let lowerCaseSocialNetworkName = "twitter"
           let socialNetworkDomain = "com"
           let userName = "KoaNdeAire"
           let appURL = URL(string: "\(lowerCaseSocialNetworkName)://user? screen_name=\(userName)")!
           let application = UIApplication.shared
         
           if application.canOpenURL(appURL) {
              application.open(appURL)
           } else {
              let webURL = URL(string:"https://\(lowerCaseSocialNetworkName).\(socialNetworkDomain)/\(userName)")!
           application.open(webURL)
           }
    }
    
    @IBAction func onClickWeb(_ sender: Any) {
        if let url = NSURL(string: "https://airelib.re"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    func setupLabelClicks() {
        let onClickProject = UITapGestureRecognizer(target: self, action: #selector(self.onClickSeeProject(_:)))
        self.tvSeeProject.addGestureRecognizer(onClickProject)
        
        let onClickLicense = UITapGestureRecognizer(target: self, action: #selector(self.onClickLicense(_:)))
        self.tvLicense.addGestureRecognizer(onClickLicense)
        
        let onClickCreator = UITapGestureRecognizer(target: self, action: #selector(self.onClickCreator(_:)))
        self.tvCreator.addGestureRecognizer(onClickCreator)
        
        let onClickIconApp = UITapGestureRecognizer(target: self, action: #selector(self.onClickIconApp(_:)))
        self.tvIconApp.addGestureRecognizer(onClickIconApp)
    }
    
    @objc func onClickSeeProject(_ sender: UITapGestureRecognizer) {
        if let url = NSURL(string: "https://github.com/melizeche/AireLibre/#faq"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    @objc func onClickLicense(_ sender: UITapGestureRecognizer) {
        if let url = NSURL(string: "https://es.wikipedia.org/wiki/GNU_Affero_General_Public_License"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    @objc func onClickCreator(_ sender: UITapGestureRecognizer) {
        if let url = NSURL(string: "https://www.linkedin.com/in/lucasginard"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    @objc func onClickIconApp(_ sender: UITapGestureRecognizer) {
        if let url = NSURL(string: "https://www.freepik.es/vector-gratis/familia-activa-feliz-caminando-al-aire-libre_7732632.htm"){
            UIApplication.shared.open(url as URL)
        }
    }
}
