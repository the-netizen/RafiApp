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

struct JournalHistory: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = JournalHistoryViewModel()

    // State to present recording and naming flows
    @State private var showRecording = false
    @State private var pendingAudioURL: URL?
    @State private var showNameSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color("bluee")
                .ignoresSafeArea()

            VStack(spacing: 16) {

                // MARK: - Header
                headerView

                // Thin line under header
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 0.5)
                    .padding(.horizontal, 24)

                // MARK: - Entries list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(viewModel.entries) { entry in
                            JournalEntryRow(entry: entry)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 96)   // space for mic button
                }
            }

            // MARK: - Mic button
            micButton
                .padding(.bottom, 24)
        }
        .fullScreenCover(isPresented: $showRecording) {
            JournalRecordingView { url in
                // When recording finishes, store URL and show name sheet
                pendingAudioURL = url
                showNameSheet = true
            }
        }
        .sheet(isPresented: $showNameSheet, onDismiss: {
            // Clear pending URL after naming flow completes or is cancelled
            pendingAudioURL = nil
        }) {
            JournalNameEntryView { title, heart in
                // Add entry if we have an audio URL
                if let url = pendingAudioURL {
                    viewModel.addEntry(title: title, heartLevel: heart, audioURL: url)
                } else {
                    // Fallback: still add an entry without audio if desired
                    viewModel.addEntry(title: title, heartLevel: heart, audioURL: nil)
                }
            } onCancel: {
                // User cancelled naming; do nothing
            }
        }
    }

    // MARK: - Header view

    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 48, height: 48)

                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                }
            }

            Spacer()

            Text("المدونة") // "Journal"
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)

            Spacer()

            Image("journalIcon")        // your blue book asset name
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }

    // MARK: - Mic button

    private var micButton: some View {
        Button(action: {
            showRecording = true
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 90, height: 90)
                    .shadow(radius: 6)

                Image("mico")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
    }
}

// MARK: - Row view for each entry

struct JournalEntryRow: View {
    let entry: JournalEntry

    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: entry.date)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)

                Text(dateText)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(entry.heartLevel > 1 ? "heartFullPixel" : "heartEmptyPixel")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        )
    }
}
