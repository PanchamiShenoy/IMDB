//
//  NetworkManager.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/7/24.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    
    func searchMovies(newText: String, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjc0ZTRiZmQzODQ5YTllYTkzMzM2NGMyZjU0OGYwYiIsInN1YiI6IjY2MTJjMDllMTk2OTBjMDE0OWEzMTVkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OUzLXGiijCmQIiiHHHmayj9-eWzAswIZsdW1Dk5u0sY"
        ]
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(newText)&api_key=fb74e4bfd3849a9ea933364c2f548f0b") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        dataTask.resume()
    }

    
    func addToFavorites(movieId: Int, completion: @escaping (Result<Bool, NetworkError>)-> Void) {
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjc0ZTRiZmQzODQ5YTllYTkzMzM2NGMyZjU0OGYwYiIsInN1YiI6IjY2MTJjMDllMTk2OTBjMDE0OWEzMTVkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OUzLXGiijCmQIiiHHHmayj9-eWzAswIZsdW1Dk5u0sY"
        ]
        let parameters = [
            "media_type": "movie",
            "movie_id": movieId,
            "favorite": true
        ] as [String : Any]
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/account/21195631/favorite")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        completion(.success(true))
                    } else {
                        completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                    }
                }
            })
            
            dataTask.resume()
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    func fetchFavoriteMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjc0ZTRiZmQzODQ5YTllYTkzMzM2NGMyZjU0OGYwYiIsInN1YiI6IjY2MTJjMDllMTk2OTBjMDE0OWEzMTVkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OUzLXGiijCmQIiiHHHmayj9-eWzAswIZsdW1Dk5u0sY"
        ]
        
        guard let url = URL(string: "https://api.themoviedb.org/3/account/21195631/favorite/movies?language=en-US&page=1&sort_by=created_at.asc&api_key=fb74e4bfd3849a9ea933364c2f548f0b") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed(error!)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(decodedData.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            } else {
                let httpResponse = response as? HTTPURLResponse
                completion(.failure(.invalidStatusCode(httpResponse?.statusCode ?? 0)))
            }
        }
        
        task.resume()
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjc0ZTRiZmQzODQ5YTllYTkzMzM2NGMyZjU0OGYwYiIsInN1YiI6IjY2MTJjMDllMTk2OTBjMDE0OWEzMTVkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OUzLXGiijCmQIiiHHHmayj9-eWzAswIZsdW1Dk5u0sY"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.invalidResponse))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(decodedData.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
