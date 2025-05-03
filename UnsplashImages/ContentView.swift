//
//  ContentView.swift
//  UnsplashImages
//
//  Created by Divyanshu rai on 13/09/24.
//

import SwiftUI



import SwiftUI

struct ContentView: View {
@StateObject private var viewModel = ViewModel()
@State private var selectedPhoto: Photos?
    

let columns = [GridItem(.adaptive(minimum: 150))]

var body: some View {
NavigationView {
VStack {
    if viewModel.photos.isEmpty {
        Text("Loading...")
            .onAppear {
               viewModel.fetchImages()
            }
    } else {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.photos) { photo in
                    AsyncImage(url: URL(string: photo.urls.regular)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .onTapGesture {
                                selectedPhoto = photo
                            }
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width:160,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal,20)
        }
    }
}
.sheet(item: $selectedPhoto) { photo in
    DetailView(photo: photo)
}
.navigationTitle("Images")
.toolbar{
    ToolbarItem(placement: .navigationBarTrailing){
        NavigationLink(destination:FavoritesView()){
            Image(systemName: "heart.fill")
        }
        
                  }
        
    
}
}
}
}

struct UrlImage:View {
   let urlString:String
 @State var  data :Data?
 var body: some View {
 if let data=data,let UiImage=UIImage(data:data){
 Image(uiImage:UiImage)
    .resizable()
    .aspectRatio(contentMode: .fill)
    .frame(width: 130,height: 70)
        .background(Color.gray)
        
}
else {
Image(systemName: "video").resizable()
    .aspectRatio(contentMode: .fill).frame(width: 100,height: 60)
    .background(Color.gray)
    .onAppear{
        fetchData()
    }
}
}
private func fetchData(){
guard let url = URL(string:urlString) else {
print("Invalid URL: \(urlString)")
return
}
let task = URLSession.shared.dataTask(with: url){_,_,_ in
guard let data = data else {
                print("No data fetched for URL: \(url)")
                return
            }
DispatchQueue.main.async {
                self.data = data
            }
}
task.resume()}
}



#Preview {
ContentView()
}
