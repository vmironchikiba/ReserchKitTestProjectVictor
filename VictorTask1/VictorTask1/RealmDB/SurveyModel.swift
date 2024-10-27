//
//  SurveyModel.swift
//  VictorTask1
//
//  Created by Mironchik on 27.10.24.
//

import Foundation
import RealmSwift
import Mantle

@objcMembers
class SurveyModel: Object {
//    required init(dictionary dictionaryValue: [AnyHashable : Any]!) throws {
//
//    }
    
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var email: String
    @Persisted var age: Int
    @Persisted var interest: Int
    
//    override required init() {
//        self.id = ObjectId()
//        self.firstName = ""
//        self.lastName = ""
//        self.email = ""
//        self.age = 0
//        self.interest = 0
//    }
}

//extension SurveyModel: MTLJSONSerializing {
//    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
//        [:]
//    }
//    
//    static func withDictionary(_ dictionaryValue: [AnyHashable : Any]!) throws -> Self {
//        Self()
//    }
//    
//    var dictionaryValue: [AnyHashable : Any]! {
//        [:]
//    }
//    
//    func mergeValue(forKey key: String!, from model: (any MTLModelProtocol)!) {
//        
//    }
//    
//    static func propertyKeys() -> Set<AnyHashable>! {
//        []
//    }
//    
//    func validate() throws {
//        
//    }
//    
//    func copy(with zone: NSZone? = nil) -> Any {
//        
//    }
//    
//
//}

extension SurveyModel {
    class func getAll() -> [SurveyModel] {
        do {
            let realm = try Realm()
            let objects = realm.objects(SurveyModel.self)
            let all: [SurveyModel] = objects.map(\.self)
            return all
        } catch {
            return []
        }
    }
    
    class func saveAll(models: [SurveyModel]) {
        do {
            let realm = try Realm()
            realm.add(models)
            try realm.commitWrite()
        } catch {
            print("Write error \(error.localizedDescription)")
        }
    }
}

