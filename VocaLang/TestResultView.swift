//
//  TestResultView.swift
//  VocaLang
//
//  Created by pablo millan lopez on 31/1/24.
//

import SwiftUI

struct TestResultView: View {
    @Bindable var wordTranslate: WordTranslate
    @Environment(\.presentationMode) var presentationMode

    
    
    var body: some View {
        ZStack{
            Color("Backgroundcell")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack{
                    Text(wordTranslate.originalLangWord)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .padding(15)
                        .foregroundColor(Color("Backgroundapp"))
                        .background(Color("ColorText"))
                        .cornerRadius(8)
                    
                    Text(wordTranslate.translateWord)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .padding(15)
                        .foregroundColor(Color("Backgroundapp"))
                        .background(Color("ColorText"))
                        .cornerRadius(8)
                }
                
                HStack{
                    //boton de fallo
                    Button(action: {
                        wordTranslate.wordKnowIt = false
                        
                        self.presentationMode.projectedValue.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "hand.thumbsdown.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                    })
                    
                    Spacer()
                    
                    //boton de acierto
                    Button(action: {
                        wordTranslate.wordKnowIt = true
                        
                        self.presentationMode.projectedValue.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.green)
                            .frame(width: 100, height: 100)
                        
                    })
                }.padding(40)
            }
        }
    }
}


