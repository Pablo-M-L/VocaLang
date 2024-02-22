//
//  ContentView.swift
//  VocaLang
//
//  Created by pablo millan lopez on 29/1/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    var testModel = false
    //let url1 = "https://translate.google.es/?hl=es&tab=TT&sl=en&tl=es&text="
    //let url2 = "&op=translate"
    @State var codeLangOrig = "en"
    @State var codeLangTrans = "es"
    var urlGoogleTranslate = "https://google.com"
    
    
    @State var showWeb = false
    @State var showTransl = true
    @State var showTestTranslate = false
    @State var showAddTranslate = false
    @State var cellword: MyItem? = nil
    @State var filterSelected = 0
    @State var searchWord = ""
    
    
    @State var originalLanguageSelected = "English"
    @State var translateLanguageSelected = "Spanish"
    
    
    //let languages = [["English","en"],["Spanish","es"]]
    let languages = ["English","Spanish","French","Portuguese", "Russian", "German","Italian"]
    struct MyItem: Identifiable {
        var id: UUID
        var myword: WordTranslate
    }
    
    var resultsWord : [WordTranslate]{
        if searchWord.isEmpty{
            return viewModel.words
        }else{
            return viewModel.words.filter{
                $0.originalLangWord.lowercased().contains(searchWord.lowercased()) ||
                $0.translateWord.lowercased().contains(searchWord.lowercased())
            }
        }
    }
    
    var body: some View {

            NavigationStack{
                ZStack{
                    
                    Color("Backgroundapp")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        HStack{
                            Picker(selection: $originalLanguageSelected, label: Text("Origin"), content: {
                                ForEach(languages, id: \.self){ lang in
                                    Text("\(lang)")
                                        .padding(.trailing,10)
                                }.foregroundColor(Color("ColorText"))
                            })
                            .onChange(of: originalLanguageSelected) { oldValue, newValue in

                                codeLangOrig = getCodeLang(lang: originalLanguageSelected)
                                UserDefaults.standard.set(codeLangOrig,forKey: "codeLangOrig")
                                UserDefaults.standard.set(originalLanguageSelected, forKey: "langOriginal")
                            }
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color("ColorText"))
                            
                            Picker(selection: $translateLanguageSelected, label: Text("Translate"), content: {
                                ForEach(languages, id: \.self){ lang in
                                    Text("\(lang)")
                                        .padding(.trailing,10)
                                }
                            }).onChange(of: translateLanguageSelected) { oldValue, newValue in
                                codeLangTrans = getCodeLang(lang: translateLanguageSelected)
                                UserDefaults.standard.set(codeLangTrans,forKey: "codeLangTrans")
                                UserDefaults.standard.set(translateLanguageSelected, forKey: "langTranslate")
                            }
                        }.foregroundColor(Color("ColorText"))
                        
                        
                        // seleccionar filtro ----------------------------------------------
                        Picker("filter", selection: $filterSelected){
                            Text("All").tag(0)
                            Image(systemName: "hand.thumbsup.fill").tag(1)
                            Image(systemName: "hand.thumbsdown.fill").tag(2)
                        }.pickerStyle(.segmented)
                            .onChange(of: filterSelected) { oldvalue, newValue in
                                // print("select \(filterSelected), \(oldvalue), \(newValue)")
                                viewModel.getWords(myfilter: filterSelected)
                            }
                            .foregroundColor(.white)
                        
                        
                        HStack{
                            if(showTransl){
                                ZStack(alignment: .center){
                                    Circle()
                                        .foregroundColor(Color("Backgroundcell"))
                                        .frame(width: 50, height: 50)
                                    
                                    Button(action: {
                                        showAddTranslate = true
                                    }, label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color("ColorText"))
                                            .frame(width: 20, height: 20)
                                        
                                        }
                                    )
                                     .sheet(isPresented: $showAddTranslate, content: {
                                            AddWordView().presentationDetents([.medium,.large])
                                        }
                                     )
                                }.shadow(color: .gray, radius: 2)
                                 .padding(10)
                                
                                Spacer()
                                
                                Text("Total words: \(viewModel.words.count)").foregroundColor(Color("ColorText"))
                            }

                            
                            
                            //boton que muestra u oculta la traduccion y el boton de comprobar.
                            Spacer()
                            
                            ZStack(alignment: .center){
                                Circle()
                                    .foregroundColor(showTransl ? Color("Backgroundcell") : Color("ColorTestButton"))
                                    .frame(width: 50, height: 50)
                                
                                Button(action: {
                                    showTransl.toggle()
                                }, label: {
                                    Image(systemName: "checkmark.bubble")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color("ColorText"))
                                        .frame(width: 25, height: 25)
                                }                                )
                            }.shadow(color: .gray, radius: 2)
                             .padding(10)
                        }
                        
                        //lista de palabras -------------------------------
                        List{
                            ForEach(resultsWord){ word in
                                
                                HStack{
                                    
                                    //pulgar indicando si se sabe o no
                                    Image(systemName: word.wordKnowIt ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                                        .resizable()
                                        .foregroundColor(word.wordKnowIt ? .green : .red)
                                        .aspectRatio(contentMode: .fit)
                                        //.padding(2)
                                        .frame(width: 25, height: 25)
                                    
                                    VStack{
                                        //celda lista con las palabras
                                        NavigationLink{
                                            //destino
                                            DetailWordView(wordTranslate: word)
                                        }label:{
                                            VStack{
                                                HStack{
                                                    Spacer()
                                                    //palabra en idioma original
                                                    Text(word.originalLangWord)
                                                        .foregroundColor(Color("ColorTextOrig"))
                                                        .font(.headline)
                                                    Spacer()
                                                }//palabra original
                                                
                                                
                                                if(showTransl){
                                                    RoundedRectangle(cornerRadius: 3)
                                                        .frame(width: UIScreen.main.bounds.size.width / 1.8, height: 4)
                                                        .foregroundColor(.black)
                                                        .shadow(color: .gray, radius: 1, y: 1)
                                                        .padding(.bottom, 4)
                                                }// division
                                                
                                                //palabra traducida o globo para test
                                                HStack{
                                                    Spacer()
                                                    
                                                    if(showTransl){
                                                        Text(word.translateWord)
                                                            .foregroundColor(Color("ColorTextTrans"))
                                                    }//palabra traducida
                                                    
                                                    if(!showTransl){
                                                        Button(action: {
                                                            cellword = MyItem(id: UUID(), myword: word)
                                                        }, label: {
                                                            Label("",systemImage: "checkmark.bubble").buttonStyle(.borderless).foregroundColor(Color("ColorText"))
                                                        }).sheet(item: $cellword){ acellword in
                                                            TestResultView(wordTranslate: acellword.myword).presentationDetents([.medium,.large])
                                                        }
                                                        .buttonStyle(.borderless)
                                                        .padding(.top, 5)
                                                    }//imagen de chech modo test
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }.buttonStyle(PlainButtonStyle())
                                            .swipeActions{
                                                Button(role: .destructive){
                                                    if(showTransl){
                                                        viewModel.deleteWord(word: word)
                                                    }
                                                }label: {
                                                    Label("",systemImage: "trash")
                                                }
                                            }
                                        

                                    }//vstack
                                    
                                    Spacer()
                                }//hstack
                                .padding(8)
                                .listRowBackground(Color("Backgroundapp"))
                                .listRowSeparator(.hidden)
                                .background(Color("Backgroundcell"))
                                .cornerRadius(8.0)
                                .shadow(color: .white, radius: 1)
                                
                                
                            } // foreach  
                    
                        }//list
                        .scrollContentBackground(.hidden)
                        .background(Color("Backgroundapp"))
                        .listStyle(.inset)
                        .navigationTitle("Vocabulary")
                        .navigationBarTitleDisplayMode(.inline)
                        .onAppear{
                            setUpApparence()
                            viewModel.getWords(myfilter: filterSelected)
                            originalLanguageSelected = UserDefaults.standard.string(forKey: "langOriginal") ?? "English"
                            translateLanguageSelected = UserDefaults.standard.string(forKey: "langTranslate") ?? "Spanish"
                        }
                        
                    }//Vstack
                    
                }
            }//navigationstak
            .searchable(text: $searchWord, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search Word")).foregroundColor(.white)
        
    }//body
        
        
    func setUpApparence(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color("Backgroundapp"))
       // UINavigationBar.appearance().tintColor = .green//UIColor(Color("background"))
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color("ColorText")),
            .font : UIFont(name:"Arial", size: 44)!]
        
        UISegmentedControl.appearance().backgroundColor = UIColor(Color("Backgroundcell"))
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("ColorBackroundSegSelected"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        

    }
    
    func getCodeLang(lang: String)->String{
        switch lang {
        case "English":
            return "en"
        case "Spanish":
            return "es"
        case "French":
            return "fr"
        case "Portuguese":
            return "pt"
        case "Russian":
            return "ru"
        case "German":
            return "de"
        case "Italian":
            return "it"
        default:
            return "en"
        }
    }
}

#Preview {
    ContentView()
}
