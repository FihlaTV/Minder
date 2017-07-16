/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

// Runs query data task, and stores results in array of users
class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([User]?, String) -> ()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    
    func getSearchResults(params : NSDictionary, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        var dataParams
        
        for(key,val) in params{
            dataParams += "&"
            dataParams += key as! String
            dataParams += "="
            dataParams += val as! String
        }
        
        if var urlComponents = URLComponents(string: ) {
            urlComponents.query = dataParams
            // 3
            guard let url = urlComponents.url else { return }
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                // 5
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSearchResults(data)
                    // 6
                    DispatchQueue.main.async {
                        completion(self.users, self.errorMessage)
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        users.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        for userDictionary in array {
            if let userDictionary = userDictionary as? JSONDictionary,
                let photoString = userDictionary["photo"] as? String,
                let photo = URL(string: photoString),
                let fname = userDictionary["fname"] as? String,
                let email = userDictionary["email"] as? String,
                let username = userDictionary["username"] as? String,
                let password = userDictionary["password"] as? String,
                let age = userDictionary["age"] as? Int,
                let ocucupation = userDictionary["ocucupation"] as? String,
                let education = userDictionary["education"] as? String,
                let status = userDictionary["status"] as? Int {
                users.append(User(fname, email, username, password, photo, age, occupation, education, status))
                index += 1
            } else {
                errorMessage += "Problem parsing UserDictionary\n"
            }
        }
    }
    
}
