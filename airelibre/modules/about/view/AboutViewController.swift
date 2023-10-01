//
//  AboutViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-10.
//

import UIKit

class AboutViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var tvSeeProject: UILabel!
    @IBOutlet weak var tvLicense: UILabel!
    @IBOutlet weak var tvIconApp: UILabel!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var btnMastodon: UIButton!
    @IBOutlet weak var containerStack: UIStackView!
        
    var collectionView: UICollectionView!
    
    private let linkColorDark = UIColor.init("176EFF")
    private var viewModel: AboutViewModel = AboutViewModel()
    
    private lazy var contributorSection:UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        
        let titleContributor = UILabel()
        titleContributor.text = "Contribuidores del proyecto"
        titleContributor.font = UIFont(name: "Rubik-Bold", size: 18)
        
        stackview.addArrangedSubview(titleContributor)
        
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelClicks()
        self.configureUI()
        self.getListContributors()
        self.configureCollectionContributors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        themeApp()
        configureUI()
    }
    
    private func configureUI(){
        if(isDarkTheme()){
            self.tvSeeProject.textColor = linkColorDark
            self.tvLicense.textColor = linkColorDark
            self.tvIconApp.textColor = linkColorDark
        }
    }
    
    private func configureCollectionContributors(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CircularItemCell.self, forCellWithReuseIdentifier: "CircularItemCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setSectionContributorIntoView(){
        contributorSection.addArrangedSubview(collectionView)
        containerStack.insertArrangedSubview(contributorSection, at: 7)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerStack.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
    }
    
    private func getListContributors(){
        self.viewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                if (self?.viewModel.contributors.isEmpty ?? true) {
                    guard let contributorSection  = self?.contributorSection else{
                        return
                    }
                    self?.containerStack.removeArrangedSubview(contributorSection)
                }else{
                    self?.setSectionContributorIntoView()
                }
                self?.collectionView.reloadData()
            }
        }
        self.viewModel.getListContributors()
    }
    
    @IBAction func onClickMastodon(_ sender: Any) {
        if let url = NSURL(string: "https://terere.social/@AireLibre"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    @IBAction func onClickTwitter(_ sender: Any) {
        let screenName =  "KoaNdeAire"
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
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
    
    @objc func onClickIconApp(_ sender: UITapGestureRecognizer) {
        if let url = NSURL(string: "https://www.freepik.es/vector-gratis/familia-activa-feliz-caminando-al-aire-libre_7732632.htm"){
            UIApplication.shared.open(url as URL)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.contributors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircularItemCell", for: indexPath) as! CircularItemCell
        
        cell.configureForContributor(with: self.viewModel.contributors[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileContributor = self.viewModel.contributors[indexPath.row].githubContributor
        if let url = URL(string: profileContributor) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

extension AboutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
