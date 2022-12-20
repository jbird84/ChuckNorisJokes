//
//  Jokes+CoreDataProperties.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/20/22.
//
//

import Foundation
import CoreData


extension Jokes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jokes> {
        return NSFetchRequest<Jokes>(entityName: "Jokes")
    }

    @NSManaged public var contents: String?

}

extension Jokes : Identifiable {

}
