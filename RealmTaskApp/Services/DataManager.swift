//
//  DataManager.swift
//  RealmTaskApp
//
//  Created by Келлер Дмитрий on 26.05.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            let shoppingList = TaskList()
            shoppingList.title = "Shoping List"
            
            let moviesList = TaskList(
            value: [
                "Movies List",
                Date(),
                [
                    ["Best film ever"] as [Any],
                    ["The best of the best", "Must have", Date(), true]
                ]
            ] as [Any]
            )
            
            let milk = Task()
            milk.title = "Milk"
            milk.note = "2L"
            
            let bread = Task(value: ["Bread", "", Date(), true] as [Any])
            let apples = Task(value: ["name": "Apples", "note": "2Kg"])
            
            shoppingList.tasks.append(milk)
            shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
            
            DispatchQueue.main.async {
                StoreManager.shared.save([shoppingList, moviesList])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
}
