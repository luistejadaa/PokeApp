//
//  FirestoreManager.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Firebase

final class RealtimeManager {
    
    static let shared: RealtimeManager = {
        let instance = RealtimeManager()
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
                completion(.success(snapshot.value as? [String: AnyObject]))
            } withCancel: { (error) in
                completion(.failure(error))
            }
    }
    
    func getChilds(path: String, completion: @escaping (Result<[[String: AnyObject]], Error>) -> Void) {
        ref
            .child(path)
            .observeSingleEvent(of: .value) { (snapshot) in
                var list = [[String: AnyObject]]()
                for snap in snapshot.children {
                    if let data = snap as? DataSnapshot {
                        if let dict = data.value as? [String: AnyObject] {
                            list.append(dict)
                        }
                    }
                }
                completion(.success(list))
            } withCancel: { (error) in
                completion(.failure(error))
            }
        }
    }
