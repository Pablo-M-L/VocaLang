//
//  WordTranslate.swift
//  VocaLang
//
//  Created by pablo millan lopez on 29/1/24.
//

import Foundation
import SwiftData

@Model
class WordTranslate {
   // @Attribute(.unique) var id: UUID
    var id: UUID = UUID()
    var originalLangWord: String = ""
    var translateWord: String = ""
    var wordKnowIt: Bool = false
    var notes: String = "Empty"
    var keyTransWord: Bool = true
    var listWordsTrans: [String] = []
   // @Relationship(deleteRule: .cascade) var wordKnowIt: WordKnowIt
    
    init(id: UUID, originalLangWord: String, translateWord: String, wordKnowIt: Bool, notes: String, keyTransWord: Bool, listWordsTrans: [String]) {
        self.id = id
        self.originalLangWord = originalLangWord
        self.translateWord = translateWord
        self.wordKnowIt = wordKnowIt
        self.notes = notes
        self.keyTransWord = keyTransWord
        self.listWordsTrans = listWordsTrans
        self.listWordsTrans = listWordsTrans
        
        
       // self.wordKnowIt = wordKnowIt
    }
    
}

/*
 @Model
 class WordKnowIt {
 var knowIt: Bool
 init(knowIt: Bool) {
 self.knowIt = knowIt
 }
 }
 */
