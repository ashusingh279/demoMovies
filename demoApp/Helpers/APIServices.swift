//
//  APIServices.swift
//  demoApp
//
//  Created by Ashutosh Singh on 02/03/25.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    private let apiKey = "cc33336b680f97799a6b41f86a152948"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Invalid Query", code: 400)))
            return
        }
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(queryEncoded)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
  
 
        func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) async {
            let urlString = "\(baseURL)/trending/movie/day?language=en-US"
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYzMzMzM2YjY4MGY5Nzc5OWE2YjQxZjg2YTE1Mjk0OCIsIm5iZiI6MTc0MDkyMjMxOC4wMTQwMDAyLCJzdWIiOiI2N2M0NWRjZTExMWNkZDRlZDhiNGE4OWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.Y8rZ_UDs9csKGOwyDDsJrJyNa5Jtegi8T1uO2mvVeTU"
            ]
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
     
}
