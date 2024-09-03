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
    @State private var selectedFilm: Films?

    var body: some View {
        NavigationView {
            VStack{
                TextField("Add new", text: self.$newFilmTitle)
                    .multilineTextAlignment(.center)
                Button("Save") {
                    self.save(film: self.selectedFilm)
                    newFilmTitle = ""
                }
                List{
                    ForEach(films, id: \.self) { 
                        film in Text(".\(film.titulo!)")
                            .onTapGesture {
                                self.newFilmTitle = film.titulo!
                                self.selectedFilm = film
                            }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            self.viewContext.delete(self.films[index])
                            try? self.viewContext.save()
                        }
                    })
                }
            }
            .navigationTitle("Lista de Filmes")
            .padding()
        }
    }
    
    func save(film: Films?) {
        if self.selectedFilm == nil {
            if self.newFilmTitle != "" {
                let newFilm = Films(context: self.viewContext)
                newFilm.titulo = newFilmTitle
                try? self.viewContext.save()
            }
        } else {
            film!.titulo = self.newFilmTitle
            try? viewContext.save()
            self.newFilmTitle = ""
            self.selectedFilm = nil
        };
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
