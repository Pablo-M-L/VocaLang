//
//  AddWordView.swift
//  VocaLang
//
//  Created by pablo millan lopez on 31/1/24.
//

import SwiftUI


struct AddWordView: View {
    @Environment(ViewModel.self) var viewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var originalWord: String = ""
    @State var translatedWord: String = ""
    @State var showGoogle = false
    
    var body: some View {
        ZStack{
            
            Color("Backgroundcell")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack{
                    
                    Text("Original:")
                        .foregroundColor(Color("ColorText"))
                    TextField("type word",text: $originalWord)
                        .padding(5)
                        .foregroundColor(Color("Backgroundapp"))
                        .background(Color("ColorText"))
                        .cornerRadius(8)
                        
                    
                }.padding(10)
                 .cornerRadius(8)
                
                VStack{
                    
                    Text("Translated:")
                        .foregroundColor(Color("ColorText"))
                    TextField("type word",text: $translatedWord)
                        .padding(5)
                        .foregroundColor(Color("Backgroundapp"))
                        .background(Color("ColorText"))
                        .cornerRadius(8)
                    
                }.padding(10)
                
                Button(action: {
                    withAnimation {
                        let newWord = WordTranslate(id: .init(), originalLangWord: originalWord, translateWord: translatedWord, wordKnowIt: false, notes: "Empty", keyTransWord: true, listWordsTrans: [])
                        viewModel.insert(word: newWord)
                        self.presentationMode.projectedValue.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Add")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                })
                .frame(width: 250)
                .clipShape(Rectangle())
                .background(.blue)
                .cornerRadius(10)
                  

                Button(action: {
                    showGoogle = true
                }, label: {
                        Text("Google Translator")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(5)
                    }
                )
                .frame(width: 250)
                .clipShape(Rectangle())
                .background(.blue)
                .cornerRadius(10)
                .sheet(isPresented: $showGoogle){
                    let url1 = "https://translate.google.es/?hl=es&tab=TT&sl="
                    let url2 = "&tl="
                    let url3 = "&text="
                    let url4 = "&op=translate"
                    let codeLangOrigin = UserDefaults.standard.string(forKey: "codeLangOrig") ?? "English"
                    let codeLangTrans = UserDefaults.standard.string(forKey: "codeLangTrans") ?? "Spanish"
                    let url = url1 + codeLangOrigin + url2 + codeLangTrans + url3 + originalWord + url4
                        SafariWebView(url: url)
                    }
                .padding(.top, 20)
            }.background(Color("Backgroundcell"))
        }
    }
}

//#Preview {
  //  AddWordView()
//}
