//
//  AppIntent.swift
//  VocaLangWidget
//
//  Created by pablo millan lopez on 24/2/24.
//

import WidgetKit
import AppIntents
import SwiftUI

struct FrecuencyNewWord: AppEntity {
    var id: String
    var hours: Int

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Hours"
    static var defaultQuery = WidgetHourQuery()
    
    var displayRepresentation: DisplayRepresentation{
            DisplayRepresentation(title: "\(id)")
    }
    
    static let allHours: [FrecuencyNewWord] = [
        FrecuencyNewWord(id: "1H",hours: 1),
        FrecuencyNewWord(id: "2H",hours: 2),
        FrecuencyNewWord(id: "3H",hours: 3),
        FrecuencyNewWord(id: "4H",hours: 4),
        FrecuencyNewWord(id: "5H",hours: 5),
        FrecuencyNewWord(id: "6H",hours: 6),
        FrecuencyNewWord(id: "7H",hours: 7),
        FrecuencyNewWord(id: "8H",hours: 8),
        FrecuencyNewWord(id: "9H",hours: 9),
        FrecuencyNewWord(id: "10H",hours: 10),
        FrecuencyNewWord(id: "11H",hours: 11),
        FrecuencyNewWord(id: "12H",hours: 12)
    ]
}

struct FilterWord: AppEntity {
    var id: String
    var code: Int

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Filter"
    static var defaultQuery = WidgetFilterQuery()
    
    var displayRepresentation: DisplayRepresentation{
            DisplayRepresentation(title: "\(id)")
    }
    
    static let allOptionsFilter: [FilterWord] = [
        FilterWord(id: "All",code: 1),
        FilterWord(id: "Known",code: 2),
        FilterWord(id: "Unknown",code: 3)
    ]
}

struct WidgetFilterQuery: EntityQuery{
    func entities(for identifiers: [FilterWord.ID]) async throws -> [FilterWord] {
        FilterWord.allOptionsFilter.filter {
            identifiers.contains($0.id)
        }
    }
    
    func suggestedEntities() async throws -> [FilterWord] {
        FilterWord.allOptionsFilter
    }
    
    func defaultResult() async -> FilterWord? {
        FilterWord.allOptionsFilter.first
    }
}

struct WidgetHourQuery: EntityQuery{
    func entities(for identifiers: [FrecuencyNewWord.ID]) async throws -> [FrecuencyNewWord] {
        FrecuencyNewWord.allHours.filter {
            identifiers.contains($0.id)
        }
    }
    
    func suggestedEntities() async throws -> [FrecuencyNewWord] {
        FrecuencyNewWord.allHours
    }
    
    func defaultResult() async -> FrecuencyNewWord? {
        FrecuencyNewWord.allHours.first
    }
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    
    static var title: LocalizedStringResource = "Configuration"
    static var description = "Select time update."

    // An example configurable parameter.
    @Parameter(title: "Change Word every:")
    
    var frequency: FrecuencyNewWord
    
    
}

