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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelClicks()
    }
        
    func setupLabelClicks() {
        let onClickProject = UITapGestureRecognizer(target: self, action: #selector(self.onClickSeeProject(_:)))
        self.tvSeeProject.isUserInteractionEnabled = true
        self.tvSeeProject.addGestureRecognizer(onClickProject)
        
        let onClickLicense = UITapGestureRecognizer(target: self, action: #selector(self.onClickLicense(_:)))
        self.tvLicense.isUserInteractionEnabled = true
        self.tvLicense.addGestureRecognizer(onClickLicense)
        
        let onClickCreator = UITapGestureRecognizer(target: self, action: #selector(self.onClickCreator(_:)))
        self.tvCreator.isUserInteractionEnabled = true
        self.tvCreator.addGestureRecognizer(onClickCreator)
        
        let onClickIconApp = UITapGestureRecognizer(target: self, action: #selector(self.onClickIconApp(_:)))
        self.tvIconApp.isUserInteractionEnabled = true
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
