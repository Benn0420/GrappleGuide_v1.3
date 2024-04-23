//
//  JournalEntryView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-05.
//

import SwiftUI

struct JournalEntryView: View {
    @StateObject var JEvc = journalEntryViewController()
    var dismissHandler: (() -> Void)? = nil
    var journalTitle: String
    var journalDescription: String
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    TextField("Journal Title", text: $JEvc.journalTitle)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 0.8 * geometry.size.width)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 20, weight: .heavy))
                        .padding()
                    TextEditor(text: $JEvc.journalDescription)
                        .textFieldStyle(.roundedBorder)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 0.8 * geometry.size.width)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 16))
                        .lineSpacing(10)
                    HStack {
                        Button("CANCEL") {
                            dismissHandler?()
                        }
                        .tint(.red)
                        .font(.system(size: 30, weight: .heavy))
                        .padding()
                        Spacer()
                        Button("SUBMIT") {
                            JEvc.submitJournal()
                            dismissHandler?()
                        }
                        .tint(.black)
                        .font(.system(size: 30, weight: .heavy))
                        .padding()
                    }
                }
                .frame(width: 0.9 * geometry.size.width, height: 0.8 * geometry.size.height)
                .background(JEvc.customLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal, 0.05 * geometry.size.width)
                .padding(.vertical, 100)
                .onAppear {
                    JEvc.journalTitle = journalTitle
                    JEvc.journalDescription = journalDescription
                }
            }
        }
    }

#Preview {
    JournalEntryView(journalTitle: "Sample Title", journalDescription: "Sample Description")
}
