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
import AVFoundation

struct JournalHistory: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var store = VoiceNotesStore()

    @State private var showRecorder = false
    @State private var showNameSheet = false
    @State private var pendingURL: URL?

    @State private var player: AVAudioPlayer?

    var body: some View {
        ZStack {
            Color("bgColor").ignoresSafeArea()

            VStack(spacing: 14) {

                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)

                Text("المدونة")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 6)

                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 1)
                    .padding(.horizontal, 24)

                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(store.notes) { note in
                            Button {
                                play(note.fileURL)
                            } label: {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(note.title)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)

                                    Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                .padding(18)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                .shadow(radius: 2)
                                .padding(.horizontal, 24)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 10)
                }

                Spacer()

                // mic button
                Button {
                    showRecorder = true
                } label: {
                    Circle()
                        .fill(Color.white.opacity(0.75))
                        .frame(width: 92, height: 92)
                        .overlay(
                            Image("Mico")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 34) // ✅ هنا حجم المايك
                                .opacity(0.6)
                        )
                }
                .padding(.bottom, 24)
            }
        }
        .fullScreenCover(isPresented: $showRecorder) {
            JournalRecordingView { url in
                // بعد ما يوقف التسجيل
                pendingURL = url
                showRecorder = false
                showNameSheet = true
            }
        }
        .sheet(isPresented: $showNameSheet) {
            JournalNameEntryView { name, rating in
                // rating جاهز عندك (لو تبينه تخزينه بعد، نضيفه في VoiceNote)
                if let url = pendingURL {
                    store.add(title: name, recordedFileURL: url)
                }
                pendingURL = nil
            }
        }
    }

    private func play(_ url: URL) {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Play error:", error.localizedDescription)
        }
    }
}
