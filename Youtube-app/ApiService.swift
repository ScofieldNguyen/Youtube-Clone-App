//
//  ApiService.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/8/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchHomeVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosFrom(urlString: baseURL + "/home.json", completion: completion)
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosFrom(urlString: baseURL + "/trending.json", completion: completion)
    }
    
    func fetchSubcriptionsVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosFrom(urlString: baseURL + "/subscriptions.json", completion: completion)
    }
    
    func fetchVideosFrom(urlString urlString: String, completion completion: @escaping ([Video]) -> ()) {
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.videoTitle = dictionary["title"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? Int
                    video.videoImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let chanel = Chanel()
                    let chanelDict = dictionary["channel"] as! [String:String]
                    chanel.chanelName = chanelDict["name"]
                    chanel.chanelImageName = chanelDict["profile_image_name"]
                    video.chanel = chanel
                    
                    video.duration = dictionary["duration"] as? Int
                    
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
}
