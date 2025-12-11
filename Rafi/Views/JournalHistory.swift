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

import SwiftUI

struct JournalHistory: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = JournalHistoryViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Color("bluee")              // your background color
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
            viewModel.toggleRecordingAndMaybeCreateEntry()
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 90, height: 90)
                    .shadow(radius: 6)

                // Your pixel mic icon
                Image("micIcon")              // change to your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .opacity(viewModel.isRecording ? 0.5 : 1.0)

                // Small red dot when recording
                if viewModel.isRecording {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 14, height: 14)
                        .offset(x: 32, y: -32)
                }
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

            // heart icon like your design
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
