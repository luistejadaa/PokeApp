//
//  FirestoreManager.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Firebase

final class FirestoreManager {
    
    static let shared: FirestoreManager = {
        let instance = FirestoreManager()
        return instance
    }()
    
    private let ref = Database.database().reference()
    
    func writeChild(path: String, id: String, values: Codable, completion: @escaping (Error?) -> Void) {
        ref
            .child(path)
            .child(id)
            .setValue(values.dictionary) { (error, _) in
                completion(error)
            }
    }
    
    /// Wrtie child with auto id
    func writeChild(path: String, values: Codable, completion: @escaping (Error?) -> Void) {
        ref
            .child(path)
            .childByAutoId()
            .setValue(values.dictionary) { (error, _) in
                completion(error)
            }
    }
    
    func updateChild(path: String, id: String, values: Codable, completion: @escaping (Error?) -> Void) {
        ref
            .child(path)
            .child(id)
            .updateChildValues(values.dictionary!) { (error, _) in
                completion(error)
            }
    }
    
    func removeChild(path: String, id: String, completion: @escaping (Error?) -> Void) {
        ref
            .child(path)
            .child(id)
            .removeValue { (error, _) in
                completion(error)
            }
    }
    
    func getChild(path: String, id: String, completion: @escaping (Result<[String: AnyObject]?, Error>) -> Void) {
        ref
            .child(path)
            .child(id)
            .observeSingleEvent(of: .value) { (snapshot) in
                completion(.success(snapshot.value as? [String:AnyObject]))
            } withCancel: { (error) in
                completion(.failure(error))
            }
    }
}
