//
//  RiverList.swift
//  River Meter
//
//  Created by Ognjen Tomic on 11.12.20..
//

import SwiftUI
import SwiftyXMLParser
import FeedKit

struct RiverList: View {
    
    var url = URL(string: "http://www.hidmet.gov.rs/latin/prognoza/prognoza_voda.rss")!
    @State var rivers: [River]
    
    var body: some View {
        
        List {
            ForEach(rivers) {river in
                VStack {
                    HStack {
                        RiverCardView(riverName: river.riverName)
                            .padding()
                            .onTapGesture {
                                print("hello there")
                            }
                        Text(river.riverPlace)
                    }
                  
                    Text(river.descriptionFetchedFromXML)
                        .padding()
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
                   

                }
               
            }
        }.resume()
    }
}

struct RiverList_Previews: PreviewProvider {
    
    static var previews: some View {
        RiverList(rivers: River.riverPreviewListData)
    }
}
