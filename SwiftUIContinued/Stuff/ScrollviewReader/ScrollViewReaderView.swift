//
//  ScrollViewReader.swift
//  SwiftUIContinued
//
//  Created by Rakha Fatih Athallah on 11/04/23.
//

import SwiftUI

struct ScrollViewReaderView: View {
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                ForEach(0..<10) { index in
                    Text("This is item number #\(index)")
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
    }
}

struct ScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderView()
    }
}
