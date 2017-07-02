//
//  GithubRepository.swift
//  github-repository-search
//
//  Created by konojunya on 2017/07/03.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import ObjectMapper

class GitHubRepositories: Mappable {
    
    var repositories = [GitHubRepository]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map){
        self.repositories <- map["items"]
    }
    
}

class GitHubRepository: Mappable {
    
    var name: String?
    var starNumber: Int?
    var language: String?
    var user: GitHubUser?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name <- map["full_name"]
        self.starNumber <- map["stargazers_count"]
        self.language <- map["language"]
        self.user <- map["owner"]
    }
    
}

class GitHubUser: Mappable {
    
    var name: String?
    var avatarUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name <- map["login"]
        self.avatarUrl <- map["avater_url"]
    }
    
}
