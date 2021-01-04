//
//  RiverCardView.swift
//  River Meter
//
//  Created by Ognjen Tomic on 3.1.21..
//

import SwiftUI

struct RiverCardView: View {
    
    let backgroundColor = Color("RiverColor")
    let bckgColor = Color("RiverColorDark")
    
    @State var riverName:String?
    @State private var userTapped:Bool = false
    
    
    var body: some View {
        
        ZStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [backgroundColor, bckgColor]), startPoint: .leading, endPoint: .topTrailing)
                Image("water")
                    .opacity(0.45)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        self.userTapped.toggle()
                    }
                    .blendMode(userTapped ? .colorDodge : .hardLight)
                    .animation(.easeInOut(duration: 1))

            }


            HStack {
                Label(
                    title: { Text(riverName ?? "Sava")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    },
                    icon: { Image(systemName: "map")
                        .font(.title)
                        .foregroundColor(.white)

                    }
                )
                
            }
            
            
        }
        .frame(width: 200, height: 200, alignment: .center)
        .cornerRadius(20)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding()
        
    }
}
#if DEBUG

struct RiverCardView_Previews: PreviewProvider {
    static var river = River.riverPreviewListData[0]
    
    static var previews: some View {
        Group {
            RiverCardView(riverName: river.reservedRiverForPreview)
                .environment(\.colorScheme, .light)
            RiverCardView(riverName: river.reservedRiverForPreview)
                .environment(\.colorScheme, .dark)


        }
    }
}
#endif
