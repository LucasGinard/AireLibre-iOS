//
//  AboutViewModel.swift
//  airelibre
//
//  Created by MacBook Pro on 2023-07-02.
//

import Foundation
import Firebase

class AboutViewModel{
    private var ref: DatabaseReference!
    var contributors: [Contributor] = []
    var onDataFetched: (() -> Void)?
    
    init() {
        ref = Database.database().reference()
    }
    
    func getListContributors() {
        let contributorsRef = ref.child("getContributors")
        contributorsRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            if let contributorsArray = snapshot.value as? NSArray {
                for case let contributorDict as NSDictionary in contributorsArray {
                    if let githubContributor = contributorDict["githubContributor"] as? String,
                       let nameContributor = contributorDict["nameContributor"] as? String,
                       let profileImage = contributorDict["profileImage"] as? String {
                        let contributor = Contributor(githubContributor: githubContributor, nameContributor: nameContributor, profileImage: profileImage)
                        self?.contributors.append(contributor)
                    }
                }
                self?.onDataFetched?()
            }
        }
    }
}
