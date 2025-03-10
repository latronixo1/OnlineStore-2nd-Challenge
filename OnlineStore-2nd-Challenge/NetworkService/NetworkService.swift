//
//  NetworkService.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//
import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let session: URLSession = .shared
    let url: String = "https://fakestoreapi.com/products"
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: url) else {
            print("Проблема с созданием ссылки")
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Произошла ошибка: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                print("Некорректный ответ сервера")
                completion(.failure(URLError(.badServerResponse)))
                return
                }
            
            guard let data = data else {
                print("Не удалось получить данные")
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
                print("Все работает")
            } catch {
                print("Ошибка при декодировании данных: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
