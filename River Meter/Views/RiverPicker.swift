//
//  RiverPicker.swift
//  River Meter
//
//  Created by Ognjen Tomic on 3.1.21..
//

import SwiftUI
import FeedKit

struct RiverPicker: View {
    
//    @State var selectedRiver:String
    @State var rivers: [River]
    var url = URL(string: "http://www.hidmet.gov.rs/latin/prognoza/prognoza_voda.rss")!

    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {

        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(0..<rivers.count, id: \.self) {
                
                    RiverCardView(riverName: rivers[$0].riverName)

                
                }
            }
        }
        .onAppear(perform: {
            fetch(url: url)
        })
    }

    
    
    func fetch(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                print("*************\(data)*************")
                let parser = FeedParser(data: data)
                // Parse asynchronously, not to block the UI.
                parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
                    // Do your thing, then back to the Main thread
                    switch result {
                    case .success(let feed):
                        // Grab the parsed feed directly as an optional rss, atom or json feed object
                        if let parsedData = feed.rssFeed?.items {
                            for item in parsedData {
                                guard let riverTitle = item.title else {return}
                                guard let description = item.description else {return}
                                let riverEntity:River = River(id: UUID(), riverTitle: riverTitle, description: description)
                                DispatchQueue.main.async {
                                    // ..and update the UI
                                    rivers.append(riverEntity)
                                    for var i in rivers {
                                        print(i.riverName)
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                    rivers.removeDuplicate()

                }
               
            }
        }.resume()
    }
}

struct RiverPicker_Previews: PreviewProvider {
    static var previews: some View {
        RiverPicker(rivers: River.riverPreviewListData)
    }
}


extension Array where Element: Equatable {
    func removeDuplicate() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}
