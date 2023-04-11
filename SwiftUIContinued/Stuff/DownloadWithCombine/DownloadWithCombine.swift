//
//  DownloadWithCombine.swift
//  SwiftUIContinued
//
//  Created by Rakha Fatih Athallah on 27/02/23.
//

import SwiftUI
import Combine

struct PostModels: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts : [PostModels] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behinde the scene
        // 3. receive the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the ITEM!!
        // 7. cancellable at any time!
        
        // 1. create the publisher
        // 2. subscribe the publisher on background thread
        // 3. receive on main thread
        // 4. tryMap (check the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModels].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }

    }
}

struct DownloadWithCombine: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
