//
//  ViewModel.swift
//  VocaLang
//
//  Created by pablo millan lopez on 29/1/24.
//

import Foundation
import SwiftData

@Observable
final class ViewModel: ObservableObject{
    let container = try! ModelContainer(for: WordTranslate.self)

    @MainActor
    var modelContext: ModelContext{
        container.mainContext
    }
    
    var words: [WordTranslate] = []
    
    @MainActor
    func getWords(myfilter: Int){
        var predicate: Predicate<WordTranslate>?
        if(myfilter == 0){
             predicate = #Predicate<WordTranslate>{ word in
                word.wordKnowIt == false || word.wordKnowIt == true
            }
        }else if(myfilter == 1){
             predicate = #Predicate<WordTranslate>{ word in
                word.wordKnowIt == true
            }
        }else if(myfilter == 2){
             predicate = #Predicate<WordTranslate>{ word in
                word.wordKnowIt == false
            }
        }
        let fetchDescriptor = FetchDescriptor<WordTranslate>(predicate: predicate, sortBy:  [SortDescriptor<WordTranslate>(\.originalLangWord)])
        words = try! modelContext.fetch(fetchDescriptor)
    }
    
    @MainActor
    func insert(word: WordTranslate){
        modelContext.insert(word)
        words = []
        getWords(myfilter: 0)
    }
    
    @MainActor
    func deleteAllWords(){
        words.forEach{
            modelContext.delete($0)
        }
        try? modelContext.save()
        words = []
        getWords(myfilter: 0)
        
    }
    
    @MainActor
    func deleteWord(word: WordTranslate){
        
        modelContext.delete(word)
        
        try? modelContext.save()
        words = []
        getWords(myfilter: 0)
        
    }
}
