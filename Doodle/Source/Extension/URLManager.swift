
import Foundation

class URLManager {
    let myKey = "405b8a57c501fcb6bbf75382f786f6af"
    
    static let shared = URLManager()
    private init(){}
    
    
    
    func getJsonData(completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=127.1086228&y=37.4012191"
        let urltoKorea = urlEncode.URLencode(urlString)
        var request = URLRequest(url: urltoKorea)
        request.setValue(myKey, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("response 에러")
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            guard let data = data else {
                print("data 에러")
                completion(.failure(NetworkError.emptyData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
enum NetworkError: Error {
    case emptyResponse
    case emptyData
}
