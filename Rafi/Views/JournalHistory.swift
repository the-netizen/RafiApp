//
//  JournalHistory.swift
//  Rafi
//
//  Created by Manar on 11/12/2025.
///
//  ContentView.swift
//  Record
//
//  Created by Manar on 10/12/2025.
//

internal import SwiftUI
import Combine

// Helper struct for sheet presentation
private struct PendingEntry: Identifiable {
    let id = UUID()
    let fileName: String
}

struct JournalHistory: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var vm = JournalHistoryViewModel()
    @StateObject private var player = AudioPlayerService()

    @State private var showRecorder = false
    @State private var pendingFileName: String? = nil

    var body: some View {
        ZStack {
            Color("bgColor").ignoresSafeArea()

            VStack(spacing: 16) {
                header

                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(vm.entries) { entry in
                            JournalRowView(entry: entry) {
                                guard !entry.audioFileName.isEmpty else { return }
                                player.togglePlay(fileName: entry.audioFileName)
                            }
                        }
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 140)
                }
            }

            // زر المايك
            VStack {
                Spacer()
                Button {
                    showRecorder = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.85))
                            .frame(width: 96, height: 96)
                            .shadow(radius: 10)

                        Image("Mico")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 46, height: 46)
                    }
                }
                .padding(.bottom, 18)
            }
        }
        .sheet(isPresented: $showRecorder) {
            JournalRecordingView { fileName, _ in
                // بعد التسجيل افتح sheet الاسم
                pendingFileName = fileName
            }
        }
        .sheet(item: Binding<PendingEntry?>(
            get: { pendingFileName.map { PendingEntry(fileName: $0) } },
            set: { _ in pendingFileName = nil }
        )) { pending in
            JournalNameEntrySheet(audioFileName: pending.fileName) { title, rating, file in
                vm.addEntry(title: title, rating: rating, audioFileName: file)
                pendingFileName = nil
            }
        }
    }

    private var header: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .padding(14)
                    .background(Circle().fill(Color.white.opacity(0.55)))
            }

            Spacer()

            Text("Journal")
                .font(.system(size: 26, weight: .bold))

            Spacer()

            Image("journal_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 34)
                .padding(10)
                .background(Circle().fill(Color.white.opacity(0.55)))
        }
        .padding(.horizontal, 18)
        .padding(.top, 10)
    }
}
