//
//  UserListModelView.swift
//  FestPlan_MobileApp
//
//  Created by etud on 27/03/2023.
//

import Foundation

enum UserListState {
    case ready
    case load([User])
    case error
}

class UserListModelView: ObservableObject {
    
    @Published public var list: [UserModelView] = []
    @Published public var hasError = false
    
    @Published var state : UserListState = .ready {
        didSet {
            switch state {
                case .load(let newList):
                    var save: [UserModelView] = []
                    for elem in newList {
                        let newModelView = UserModelView(email: elem.email, name: elem.name, surname: elem.surname)
                        save.append(newModelView)
                    }
                    list = save
                print(list[1].surname)
                print(list[0].surname)
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("UserViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> UserModelView {
        get {
            return list[index]
        }
    }
    
    init(list: [UserModelView]? = nil) {
        if let list = list {
            self.list = list
        }
    }

}

