//
//  GithubAPI.swift
//  github-repository-search
//
//  Created by konojunya on 2017/07/03.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import APIKit
import ObjectMapper

// protocolをまずつくる
protocol GitHubRequest: Request {
    
}

// 拡張する
extension GitHubRequest {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
}

// 構造体を定義する
struct FetchRepositoriesRequest: GitHubRequest {
    
    var query: String?
    var sort: String?
    var order: String?
    
    typealias Response = GitHubRepositories
    
    var path: String {
        return "/search/repositories"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Any? {
        return [
            "q": self.query,
            "sort": self.sort,
            "order": self.order
        ]
    }
    
    init(query: String, sort: String, order: String) {
        self.query = query
        self.sort = sort
        self.order = order
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRepositoriesRequest.Response {
        return Mapper<GitHubRepositories>().map(JSONObject: object)!
    }
    
}
