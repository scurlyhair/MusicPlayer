//
//  AccountLocalAccessor.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/14.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Combine
import CoreData
import Foundation

protocol AccountLocalAccessor: DBService {
    func queryAccount(username: String) -> AnyPublisher<[Account], Error>
    func insertAccount(username: String, token: String) -> AnyPublisher<Account, Error>
    func updateAccount(username: String, token: String) -> AnyPublisher<Account, Error>
}

struct RealAccountLocalAccessor: AccountLocalAccessor {
    var coreDataStack: CoreDataStack

    func queryAccount(username: String) -> AnyPublisher<[Account], Error> {
        let query = Future<[Account], Error> { [weak coreDataStack] promise in
            coreDataStack?.bgQueue.async {
                let context = coreDataStack?.privateContext()
                let request = NSFetchRequest<Account>(entityName: "Account")
                context?.perform {
                    do {
                        let result = try context?.fetch(request).filter { $0.username == username }
                        promise(.success(result ?? []))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        return query.eraseToAnyPublisher()
    }

    func insertAccount(username: String, token: String) -> AnyPublisher<Account, Error> {
        let insert = Future<Account, Error> { [weak coreDataStack] promise in
            coreDataStack?.bgQueue.async {
                let context = coreDataStack?.privateContext()
                let account = Account(entity: Account.entity(), insertInto: context)
                account.username = username
                account.token = token

                if context?.hasChanges ?? false {
                    do {
                        try context?.save()
                        promise(.success(account))
                    } catch {
                        promise(.failure(error))
                    }
                } else {
                    promise(.failure(DBError.contextNotChange))
                }
            }
        }
        return insert.eraseToAnyPublisher()
    }

    func updateAccount(username: String, token: String) -> AnyPublisher<Account, Error> {
        let udpate = Future<Account, Error> { [weak coreDataStack] promise in
            coreDataStack?.bgQueue.async {
                let context = coreDataStack?.privateContext()
                let request = NSFetchRequest<Account>(entityName: "Account")
                context?.perform {
                    do {
                        guard let account = try context?.fetch(request).filter({ $0.username == username }).first else {
                            promise(.failure(DBError.itemNotFount))
                            return
                        }
                        account.token = token
                        try context?.save()
                        promise(.success(account))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        return udpate.eraseToAnyPublisher()
    }
}
