//
//  LoadVideoOperation.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

class LoadVideoOperation: ConcurrentOperation {
    
    // MARK: - Class Properties
    
    static var fileLookup = Dictionary<URL, URL>() // get local url if file is already downloaded to temp dir
    static var loadVideoQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "LoadVideoQueue"
        return queue
    }()
    
    // MARK: - Private Properties
    
    private var callback: (URL?) -> Void
    
    private var sourceURL: URL
    private var fileURL: URL?
    
    private lazy var fetchDataOperation = FetchDataOperation(url: sourceURL)
    
    private lazy var saveOperation = BlockOperation {
        guard !self.isCancelled else { return }
        guard let data = self.fetchDataOperation.data else {
            self.cancel()
            return
        }
        
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let fileName = self.sourceURL.lastPathComponent
        let fileURL = temporaryDirectory.appendingPathComponent(fileName)
        print(fileURL)
        do {
            try data.write(to: fileURL)
            self.fileURL = fileURL
            Self.fileLookup[self.sourceURL] = self.fileURL
        } catch {
            print("⚠️ Error writing video to disk: \(error)")
            self.cancel()
            return
        }
    }
    
    // MARK: - Init
    
    init(url: URL, callback: @escaping ((URL?) -> Void)) {
        self.sourceURL = url
        self.callback = callback
        super.init()
        Self.loadVideoQueue.addOperation(self)
    }

    // MARK: - Lifecycle Methods
    
    override func main() {
        if let fileURL = Self.fileLookup[sourceURL] {
            DispatchQueue.main.async {
                self.callback(fileURL)
            }
            finish()
            return
        }
        
        saveOperation.addDependency(fetchDataOperation)
        
        Self.loadVideoQueue.addOperations([fetchDataOperation, saveOperation], waitUntilFinished: true)
        
        DispatchQueue.main.async {
            self.callback(self.fileURL)
        }
        self.finish()
    }
    
    override func cancel() {
        self.fetchDataOperation.cancel()
        super.cancel()
    }
}
