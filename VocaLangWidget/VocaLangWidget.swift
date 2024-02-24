//
//  VocaLangWidget.swift
//  VocaLangWidget
//
//  Created by pablo millan lopez on 24/2/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: AppIntentTimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),word: getAppWords(), configuration: ConfigurationAppIntent())
    }

    @MainActor func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date() ,word: getAppWords(), configuration: configuration)
    }
    
    @MainActor func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        print(configuration.frequency)
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: (hourOffset * configuration.frequency.hours), to: currentDate)!
            let entry = SimpleEntry(date: entryDate,word: getAppWords(), configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    
    @MainActor
    private func getAppWords() -> WordTranslate{
    
        
        guard let modelContainer = try? ModelContainer(for: WordTranslate.self) else {
            return WordTranslate(id: UUID(), originalLangWord: "nada", translateWord: "nada", wordKnowIt: false, notes: "nada", keyTransWord: false, listWordsTrans: [""])
        }

        let descriptor = FetchDescriptor<WordTranslate>()
        let wordsList = try? modelContainer.mainContext.fetch(descriptor)

        return wordsList?.randomElement() ?? WordTranslate(id: UUID(), originalLangWord: "nada", translateWord: "nada", wordKnowIt: false, notes: "nada", keyTransWord: false, listWordsTrans: [""])
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let word: WordTranslate
    let configuration: ConfigurationAppIntent
}

struct VocaLangWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family


    var body: some View {
    
            //Text("Time:")
            //Text(entry.date, style: .time)
        
        switch family{
        case .systemSmall:
            ZStack{
                
                Color("Backgroundapp")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack{
                        Spacer()
                        //palabra en idioma original
                        Text(entry.word.originalLangWord)
                            .foregroundColor(Color("ColorTextOrig"))
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        Spacer()
                    }//palabra original
                    

                        RoundedRectangle(cornerRadius: 3)
                        .frame(width: UIScreen.main.bounds.size.width / 3.5, height: 6)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 2, y: 2)
                            .padding(.bottom, 4)
                    
                    //palabra traducida o check para test
                    HStack{
                        Spacer()
                        
                        Text(entry.word.translateWord)
                            .foregroundColor(Color("ColorTextTrans"))
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        Spacer()
                    }
                }//vstack
                
                
            }.cornerRadius(10)
            
        case .systemMedium:
            ZStack{
                
                Color("Backgroundapp")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack{
                        Spacer()
                        //palabra en idioma original
                        Text(entry.word.originalLangWord)
                            .foregroundColor(Color("ColorTextOrig"))
                            .font(.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        Spacer()
                    }//palabra original
                    

                        RoundedRectangle(cornerRadius: 3)
                            .frame(width: UIScreen.main.bounds.size.width / 1.8, height: 4)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 1, y: 1)
                            .padding(.bottom, 4)
                    
                    //palabra traducida o check para test
                    HStack{
                        Spacer()
                        
                        Text(entry.word.translateWord)
                            .foregroundColor(Color("ColorTextTrans"))
                            .font(.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        Spacer()
                    }
                }//vstack
                
                
            }.cornerRadius(10)
            
        case .systemLarge:
            ZStack{
                
                Color("Backgroundapp")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack{
                        Spacer()
                        //palabra en idioma original
                        Text(entry.word.originalLangWord)
                            .foregroundColor(Color("ColorTextOrig"))
                            .font(.largeTitle)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        Spacer()
                    }//palabra original
                    

                        RoundedRectangle(cornerRadius: 3)
                            .frame(width: UIScreen.main.bounds.size.width / 1.8, height: 4)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 1, y: 1)
                            .padding(.bottom, 4)
                    
                    //palabra traducida o check para test
                    HStack{
                        Spacer()
                        
                        Text(entry.word.translateWord)
                            .foregroundColor(Color("ColorTextTrans"))
                            .font(.largeTitle)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        Spacer()
                    }
                }//vstack
                
                
            }.cornerRadius(10)
            
        case .systemExtraLarge:
            ZStack{
                
                Color("Backgroundapp")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack{
                        Spacer()
                        //palabra en idioma original
                        Text(entry.word.originalLangWord)
                            .foregroundColor(Color("ColorTextOrig"))
                            .font(.title)
                        Spacer()
                    }//palabra original
                    

                        RoundedRectangle(cornerRadius: 3)
                            .frame(width: UIScreen.main.bounds.size.width / 1.8, height: 4)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 1, y: 1)
                            .padding(.bottom, 4)
                    
                    //palabra traducida o check para test
                    HStack{
                        Spacer()
                        
                        Text(entry.word.translateWord)
                            .foregroundColor(Color("ColorTextTrans"))
                            .font(.title)
                        
                        Spacer()
                    }
                }//vstack
                
                
            }.cornerRadius(10)
            
            
        @unknown default:
            fatalError()
        }

    }
}

struct VocaLangWidget: Widget {
    let kind: String = "VocaLangWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()) { entry in
                VocaLangWidgetEntryView(entry: entry)
                    .modelContainer(for: [WordTranslate.self])
                    .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}


/*
extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.frequency = FrecuencyNewWord(id: "50", hours: 50)
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.frequency = FrecuencyNewWord(id: "50", hours: 50)
        return intent
    }
}

#Preview(as: .systemSmall) {
    VocaLangWidget()
} timeline: {
    SimpleEntry(date: .now, word: WordTranslate(id: UUID(), originalLangWord: "nada", translateWord: "nada", wordKnowIt: false, notes: "nada", keyTransWord: false, listWordsTrans: [""])  ,configuration: .smiley)
    SimpleEntry(date: .now, word: WordTranslate(id: UUID(), originalLangWord: "nada", translateWord: "nada", wordKnowIt: false, notes: "nada", keyTransWord: false, listWordsTrans: [""]), configuration: .starEyes)
}
 */
