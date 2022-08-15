//
//  DialogInfoAQIViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-08-13.
//

import UIKit

class DialogInfoAQIViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnCloseDialog: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        themeApp()
        configureUI()
    }
    
    func configureUI(){
        if(isDarkTheme()){
            btnCloseDialog.setImage(UIImage(named: "iconClose"), for: .normal)
            btnCloseDialog.imageView?.contentMode = .scaleAspectFit
        }else{
            btnCloseDialog.setImage(UIImage(named: "icon_close_black"),for: .normal)
        }
        
        let onClickIconApp = UITapGestureRecognizer(target: self, action: #selector(self.onClickIconApp(_:)))
        self.containerView.addGestureRecognizer(onClickIconApp)
        
    }

    @IBAction func clickCloseDialog(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickIconApp(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
