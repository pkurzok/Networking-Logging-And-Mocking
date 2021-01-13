//
//  ContentView.swift
//  Networking
//
//  Created by Peter Kurzok on 13.01.21.
//

import SwiftUI

struct ContentView: View {
    var viewModel: ContentViewModel

    init(viewModel: ContentViewModel = ContentViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                viewModel.fetchData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
