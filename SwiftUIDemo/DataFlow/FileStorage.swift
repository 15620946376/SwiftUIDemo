//
//  FileStorage.swift
//  SwiftUIDemo
//
//  Created by hanfei on 2021/11/8.
//

import Foundation

@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        self.directory = directory
        self.fileName = fileName
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            if let value = value {
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            } else {
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        get {
            return value
        }
    }
}
