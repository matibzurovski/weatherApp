//
//  PersistenceController.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import RealmSwift

class PersistenceController {
    
    // MARK: - Singleton
    
    static let shared = PersistenceController()
    
    fileprivate init() {
    }
    
    // MARK: - CRUD
    
    func createObject(_ object: Object, update: Realm.UpdatePolicy = .error) throws {
        let realm = try Realm()
        
        try realm.write {
            realm.add(object, update: update)
        }
    }
    
    func objectForPrimaryKey<T: Object>(_ type: T.Type, primaryKey: Any) throws -> T? {
        let realm = try Realm()
        return realm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    func readAll<T: Object>(_ type: T.Type) throws -> [T] {
        let realm = try Realm()
        
        let results = realm.objects(type)
        
        var array: [T] = []
        for item in results {
            array.append(item)
        }
        return array
    }
    
    func updateObject(_ changes: @escaping () -> Void) throws {
        
        let realm = try Realm()
        
        try realm.write {
            changes()
        }
    }
    
    func deleteObject(_ object: Object) throws {
        
        guard let realm = object.realm else {
            print("Attempted to delete an object which isn't in any Realm: \(object)")
            return
        }
        
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAllObjectsOfType<T: Object>(_ type: T.Type) throws {
        let realm = try Realm()
        try realm.write {
            let objects = realm.objects(type)
            realm.delete(objects)
        }
    }
    
    func deleteAllObjectsOfType<T: Object>(_ type: T.Type, filter: NSPredicate) throws {
        let realm = try Realm()
        let objectsToDelete = realm.objects(type).filter(filter)
        
        try realm.write {
            realm.delete(objectsToDelete)
        }
    }
}
