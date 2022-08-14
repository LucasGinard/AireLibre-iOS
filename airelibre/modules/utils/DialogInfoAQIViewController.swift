//
//  DialogInfoAQIViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-08-13.
//

import UIKit

class DialogInfoAQIViewController: UIViewController {

    @IBOutlet weak var btnCloseDialog: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        themeApp()
        configureUI()
    }

    @IBAction func clickCloseDialog(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureUI(){
        if(isDarkTheme()){
            btnCloseDialog.setImage(UIImage(named: "iconClose"), for: .normal)
            btnCloseDialog.imageView?.contentMode = .scaleAspectFit
        }else{
            btnCloseDialog.setImage(UIImage(named: "icon_close_black"),for: .normal)
        }
        
    }
    
}
