//
//  ContentView.swift
//  Lingue
//
//  Created by Michele Manniello on 16/02/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var selectedSpeach = 0
    let speechVoices = AVSpeechSynthesisVoice.speechVoices()
    @State private var utterance = AVSpeechUtterance(string: "Select a speech Voice")
    let synthesizer = AVSpeechSynthesizer()
    let current = Locale.current.languageCode
    static let formatLanguage : NSLocale = {
        let current = Locale.current.languageCode
        let language = NSLocale.init(localeIdentifier: current!)
        return language
    }()
    var body: some View {
        VStack{
            Text(utterance.speechString)
                .font(.system(size: 30))
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            Picker(selection: $selectedSpeach, label: Text("Please choose a Speach Voice"), content: {
                ForEach(0..<speechVoices.count){ i in
                    Text(Self.formatLanguage.displayName(forKey: NSLocale.Key.identifier,value: speechVoices[i].language) ?? "")
                }
            })
            Button(action: {
                if !synthesizer.isSpeaking{
                    self.utterance = AVSpeechUtterance(string: "I have  \(Self.formatLanguage.displayName(forKey: NSLocale.Key.identifier, value: speechVoices[selectedSpeach].language) ?? "")accent")
                    utterance.voice = speechVoices[selectedSpeach]
                    synthesizer.speak(utterance)
                }
            }, label: {
                    Text("Listen")
                        .frame(width: 100, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
