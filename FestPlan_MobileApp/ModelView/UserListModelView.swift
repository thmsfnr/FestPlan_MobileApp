//
//  UserListModelView.swift
//  FestPlan_MobileApp
//
//  Created by Loris Bouchez on 27/03/2023.
//

import Foundation

enum UserListState {
    case ready
    case load([User])
    case loadSlot([User])
    case loadFree([User])
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
                        let newModelView = UserModelView(idUser: elem.idUser, email: elem.email, name: elem.name, surname: elem.surname)
                        save.append(newModelView)
                    }
                    list = save
                    self.state = .ready
                case .loadSlot(let newList):
                    var save: [UserModelView] = []
                    for elem in newList {
                        let newModelView = UserModelView(idUser: elem.idUser, email: elem.email, name: elem.name, surname: elem.surname)
                        save.append(newModelView)
                    }
                    list = save
                    self.state = .ready
                case .loadFree(let newList):
                    var save: [UserModelView] = []
                    for elem in newList {
                        let newModelView = UserModelView(idUser: elem.idUser, email: elem.email, name: elem.name, surname: elem.surname)
                        save.append(newModelView)
                    }
                    list = save
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

