//
//  ContentView.swift
//  CRUDCoreData
//
//  Created by Josimar da Cunha Ferreira on 30/08/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Films.entity(), sortDescriptors: [])
    
    private var films: FetchedResults<Films>
    @State private var newFilmTitle = ""

    var body: some View {
        VStack{
            TextField("Add new", text: self.$newFilmTitle)
                .multilineTextAlignment(.center)
            Button("Save") {
                self.save()
                newFilmTitle = ""
            }
            List{
                ForEach(films, id: \.self) { film in
                    Text("\(film.titulo!)")
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        self.viewContext.delete(self.films[index])
                        try? self.viewContext.save()
                    }
                })
            }
        }
    }
    
    func save() {
        let newFilm = Films(context: self.viewContext)
        newFilm.titulo = newFilmTitle
        try? self.viewContext.save()
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
