//
//  NetworkService.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//
import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let session: URLSession = .shared
    
    // MARK: - Загрузка продуктов
    func fetchProducts(from url: String, completion: @escaping (Result<[Product], Error>) -> Void) {
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
                print("Данные успешно загружены")
            } catch {
                print("Ошибка при декодировании данных: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Загрузка изображения
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Неверный URL для изображения")
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Произошла ошибка при загрузке изображения: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Некорректный ответ сервера при загрузке изображения")
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                print("Не удалось преобразовать данные в изображение")
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
}
