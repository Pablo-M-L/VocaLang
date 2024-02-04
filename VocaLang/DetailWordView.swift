//
//  DetailWordView.swift
//  VocaLang
//
//  Created by pablo millan lopez on 31/1/24.
//

import SwiftUI

struct DetailWordView: View {
    @Bindable var wordTranslate: WordTranslate
    
    let url1 = "https://translate.google.es/?hl=es&tab=TT&sl="
    let url2 = "&tl="
    let url3 = "&text="
    let url4 = "&op=translate"
    let codeLangOrigin = UserDefaults.standard.string(forKey: "codeLangOrig") ?? "English"
    let codeLangTrans = UserDefaults.standard.string(forKey: "codeLangTrans") ?? "Spanish"
    
    var body: some View {
        ZStack{
            
            Color("Backgroundapp")
                .edgesIgnoringSafeArea(.all)
            
            VStack{

                
                VStack{
                    
                    Text("Original:")
                        .foregroundColor(Color("ColorText"))
                    TextField("type word",text: $wordTranslate.originalLangWord)
                        .padding(5)
                        .foregroundColor(Color("Backgroundapp"))
                        .background(Color("ColorText"))
                        .cornerRadius(8)
                        
                    
                }.padding(10)
                 .cornerRadius(8)
                
                VStack{
                    
                    Text("Translated:")
                        .foregroundColor(Color("ColorText"))
                    TextField("type word",text: $wordTranslate.translateWord)
                        .padding(5)
                        .foregroundColor(Color("Backgroundapp"))
                        .background(Color("ColorText"))
                        .cornerRadius(8)
                    
                }.padding(10)

                Spacer()
                              
                VStack{
                    SafariWebView(url: url1 + codeLangOrigin + url2 + codeLangTrans + url3 + wordTranslate.originalLangWord+url4)
                }
                              
            }
        }
    }
}

//#Preview {
  //  DetailWordView(originalWord: "orig", translatedWord: "trans")
//}
