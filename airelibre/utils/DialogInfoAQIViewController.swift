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
    @IBOutlet weak var tableViewInfo: UITableView!
    
    private var titlesList = ["0-50 | Libre","51-100 | Maso","101-150 | No tan bien","151-200 | Insalubre","201-300 | Muy insalubre","300+ | Peligroso"]
    private var descriptionList = [
        "Escaso riesgo de contaminación atmosférica, calidad de aire satisfactoria.",
        "Calidad de aire aceptable, riesgo moderado para la salud de personas sensibles a la contaminación ambiental.",
        "Insalubre para personas sensibles.",
        "Riesgo general para las personas, efectos más graves en personas sensibles.",
        "Condición de emergencia.",
        "Alerta sanitaria, efectos graves para toda la población."
    ]
    private var backgroundList = ["A2DC61","F6D550","EE9955","E9686C","A97BBC","9B5974"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        themeApp()
        configureUI()
        configureTable()
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
    
    func configureTable(){
        tableViewInfo.dataSource = self
        tableViewInfo.register(UINib(nibName: "InfoAQITableViewCell", bundle: nil), forCellReuseIdentifier: "InfoAQITableViewCell")
    }

    @IBAction func clickCloseDialog(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickIconApp(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension DialogInfoAQIViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoAQITableViewCell")
        (cell as? InfoAQITableViewCell)?.configureCell(
            title: "\(titlesList[indexPath.row])",
            description: "\(descriptionList[indexPath.row])",
            backgroundColor: backgroundList[indexPath.row])
        return cell!
    }
    
}

