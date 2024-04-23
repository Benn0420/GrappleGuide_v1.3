//
//  JournalView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-05.
//

import SwiftUI

struct JournalView: View {
    @StateObject var Jvc = journalViewController()

    var body: some View {
        ZStack {
            Image("GrappleGuideBkrnd")
                .resizable()
                .cornerRadius(20)
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    List {
                        ForEach(Jvc.journals, id: \.id) { journal in
                            HStack {
                                Text(journal.name)
                                    .onTapGesture {
                                        Jvc.selectedJournal = journal
                                        Jvc.isShowingJournalEditor.toggle()
                                    }
                                Spacer()
                                Button(action: {
                                    Jvc.selectedJournal = journal
                                    Jvc.isShowingAlert.toggle()
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundStyle(Color.red)
                                }
                            }
                        }
                    }
                    .background(Jvc.customLightGray)
                    .scrollContentBackground(.hidden)
                    .fullScreenCover(isPresented: $Jvc.isShowingJournalEditor) {
                        JournalEntryView(dismissHandler: {
                            Jvc.fetchJournals()
                            Jvc.isShowingJournalEditor.toggle()
                        }, journalTitle: Jvc.selectedJournal?.name ?? "", 
                                         journalDescription: Jvc.selectedJournal?.description ?? "")
                    }
                    .alert(isPresented: $Jvc.isShowingAlert) {
                        Alert(
                            title: Text("Confirm Deletion"),
                            message: Text("Are you sure you want to delete this journal?"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let selectedJournal = Jvc.selectedJournal {
                                    Jvc.deleteJournal(journalName: selectedJournal.name)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    Button (action: {
                        Jvc.isShowingJournalEntry.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 20)
                }
                .frame(width: 0.9 * geometry.size.width,
                       height: 0.8 * geometry.size.height)
                .background(Jvc.customLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal, 0.05 * geometry.size.width)
                .padding(.vertical, 100)
                .fullScreenCover(isPresented: $Jvc.isShowingJournalEntry) {
                    JournalEntryView(dismissHandler: {
                        Jvc.fetchJournals()
                        Jvc.isShowingJournalEntry.toggle()
                    }, journalTitle: "", journalDescription: "")
                        .background(Color.black)
                }
            }
        }
    }
}

#Preview {
    JournalView()
}
