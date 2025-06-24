//
//  SearchRowView.swift
//  booklist
//
//  Created by Honoka Nishiyama on 2025/06/24.
//

import SwiftUI

struct SearchRowView: View {
    @State var isSaved: Bool = false
    let imageUrl: String?
    let title: String?
    let publisher: String?
    var body: some View {
        HStack{
            if let thumbnailUrl = imageUrl{
                AsyncImage(url: URL(string: thumbnailUrl)){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            }
            VStack(alignment: .leading){
                Text(title ?? "")
                    .font(.headline)
                    .bold()
                Text(publisher ?? "")
                    .font(.caption)
            }
            Spacer()
            Button(action: {
                guard !isSaved else {return}
                let newBook = BookSummary(id: UUID().uuidString,
                                          title: title ?? "",
                                          thumbnail: imageUrl)
                SwiftDataManager().saveItem(data: newBook)
                isSaved = true
            }, label: {
                Image(systemName: isSaved ? "checkmark.circle.fill" : "plus.circle")
            })
            .buttonStyle(PlainButtonStyle())
        }
        .frame(minHeight: 100)
    }
}

#Preview {
    SearchRowView(
        imageUrl: sampleImageUrl,
        title: "本のタイトル",
        publisher: "出版社"
    )
}
