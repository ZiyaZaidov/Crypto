//
//  LoacalFileManager.swift
//  Crypto
//
//  Created by Ziya Zaidov on 28.12.2023.
//

import Foundation
import SwiftUI


class LoacalFileManager {
    
    static let instance = LoacalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, folderName: String, imageName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(), let url = getImageURL(imageName: imageName, folderName: folderName) else {return}
        
        do {
            try data.write(to: url)
        } catch let error {
            print("DEBUG: can't save image - \(error.localizedDescription). imageName: \(imageName)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getImageURL(imageName: imageName, folderName: folderName), FileManager.default.fileExists(atPath: url.path) else {return nil}
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("DEBUG: can't create directory - \(error.localizedDescription). Folder name: \(folderName)")
            }
        }
    }
    
    private func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        return url.appendingPathComponent(folderName)
    }
    
    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getUrlForFolder(folderName: folderName) else {return nil}
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
