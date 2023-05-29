//
//  DogService.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/7/23.
//

import Foundation

enum DogCallingError: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
    case emptyData
}

class DogService {
    private let urlString = "https://run.mocky.io/v3/a47562d4-8a0b-4eaf-a050-8ac15f43896f"
    
    func getDogs(completion: @escaping ([Dog]?, Error?) -> ()) {
            guard let url = URL(string: self.urlString) else {
                DispatchQueue.main.async { completion(nil, DogCallingError.problemGeneratingURL) }
                return
        }
                
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async { completion(nil, DogCallingError.problemGettingDataFromAPI) }
                    return
                }
                
                do {
                    let dogResult = try JSONDecoder().decode(DogResult.self, from: data)
                    if dogResult.dogs.isEmpty {
                        DispatchQueue.main.async { completion([], DogCallingError.emptyData) }
                    } else {
                        DispatchQueue.main.async { completion(dogResult.dogs, nil) }
                    }
                } catch (let error) {
                    print(error)
                    DispatchQueue.main.async { completion(nil, DogCallingError.problemDecodingData) }
                }
                                                        
            }
            task.resume()
        }
}
