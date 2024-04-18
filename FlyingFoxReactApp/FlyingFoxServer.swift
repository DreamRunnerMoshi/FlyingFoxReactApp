//
//  FireFlyServer.swift
//  FlyingFoxReactApp
//
//  Created by Md Moshiur Rahman on 18/4/24.
//

import Foundation
import FlyingFox

public class FlyingFoxServer {
    
    public func Start() async -> Void {
        
        let port : UInt16 = 61002
        
        let server = HTTPServer(port: port)
        
        await server.appendRoute("/home"){ request in
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let response = HTTPResponseBuilder.createHTMLResponse()
            return response
        }
        
        //await server.appendRoute("GET /*", to: .directory(subPath: "", serverPath: "/"))
        await server.appendRoute("GET /manifest.json", to: .file(named: "manifest.json"))
        await server.appendRoute("GET /static/js/*", to: .directory(subPath: "", serverPath: "/static/js/"))
        await server.appendRoute("GET /static/css/*", to: .directory(subPath: "", serverPath: "/static/css/"))
        await server.appendRoute("GET /static/media/*", to: .directory(subPath: "", serverPath: "/static/media/"))
        // GET /mock/fish/index.html  ---->  Stubs/fish/index.html
        
        do {
            try await server.start()
        }catch (let error) {
            print("Server cannot started at \(error)")
        }
    }
}

public struct HTTPResponseBuilder {
    
    public static func createHTMLResponse() -> HTTPResponse {
        do {
            let htmlContent = try HTTPResponseBuilder.loadHTMLContent()
            if(htmlContent.isEmpty) {
                return HTTPResponse(statusCode: .internalServerError)
            }else {
                return HTTPResponse(statusCode: .ok, body: Data(htmlContent.utf8))
            }
        } catch {
            return HTTPResponse(statusCode: .internalServerError)
        }
    }
    
    // Convenience initializer for creating an HTTPResponse with HTML content
    public static func loadHTMLContent() throws -> String {
        // Create an HTML content string
        guard let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html"),
              let htmlData = try? Data(contentsOf: htmlURL),
              let htmlString = String(data: htmlData, encoding: .utf8) else {
            return ""
        }
        
        return htmlString
    }
}
