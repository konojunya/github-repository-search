//
//  GitHubRepository.swift
//  github-repostory-search
//
//  Created by konojunya on 2017/07/04.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import ObjectMapper

class GithubRepositories: Mappable {
    var repositories = [GithubRepository]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        repositories <- map["items"]
    }
}

class GithubRepository: Mappable {
    var name: String?
    var starNumber: Int?
    var language: String?
    var user: GithubUser?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["full_name"]
        starNumber <- map["stargazers_count"]
        language <- map["language"]
        user <- map["owner"]
    }
}

class GithubUser: Mappable {
    var name: String?
    var avatarUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["login"]
        avatarUrl <- map["avatar_url"]
    }
}
