import Foundation
import XCPlayground
import PlaygroundSupport



let username = "ARREN\\TST01g"
let password = "JXF83V"
let loginString = String(format: "%@:%@", username, password)
let loginData = loginString.data(using: String.Encoding.utf8)!
let base64LoginString3 = loginData.base64EncodedString()

if let someURL = URL(string: "https://apptelesitestest.azurewebsites.net/login") {
    var req = URLRequest(url: someURL)
    // This changes the HTTP method in the request line
    req.httpMethod = "GET"
    req.setValue("Basic \(base64LoginString3)", forHTTPHeaderField: "Authorization")
    req.setValue("2", forHTTPHeaderField: "AUTHMODE")
    //req.allHTTPHeaderFields
    // If you wanted to set a request header, such as the Accept header
    //req.setValue("text/json", forHTTPHeaderField: "Accept")
    //let urlConnection = NSURLConnection(request: request, delegate: self)
    NSURLConnection.sendAsynchronousRequest(req, queue: OperationQueue.main) {(response, data, error) in
        print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
