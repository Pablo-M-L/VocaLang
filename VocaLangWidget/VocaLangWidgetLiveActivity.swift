//
//  VocaLangWidgetLiveActivity.swift
//  VocaLangWidget
//
//  Created by pablo millan lopez on 24/2/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct VocaLangWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct VocaLangWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: VocaLangWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension VocaLangWidgetAttributes {
    fileprivate static var preview: VocaLangWidgetAttributes {
        VocaLangWidgetAttributes(name: "World")
    }
}

extension VocaLangWidgetAttributes.ContentState {
    fileprivate static var smiley: VocaLangWidgetAttributes.ContentState {
        VocaLangWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: VocaLangWidgetAttributes.ContentState {
         VocaLangWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: VocaLangWidgetAttributes.preview) {
   VocaLangWidgetLiveActivity()
} contentStates: {
    VocaLangWidgetAttributes.ContentState.smiley
    VocaLangWidgetAttributes.ContentState.starEyes
}
