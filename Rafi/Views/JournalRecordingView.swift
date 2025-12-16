//
//  JournalRecordingView.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

internal import SwiftUI

struct JournalRecordingView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var recorder = AudioRecorderService()

    @State private var permissionDenied = false
    @State private var currentFileName: String = AudioRecorderService.generateFileName()

    let onFinished: (String, TimeInterval) -> Void

    var body: some View {
        ZStack {
            Color("bgColor").ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer().frame(height: 40)

                Text(timeString(recorder.elapsed))
                    .font(.system(size: 34, weight: .semibold, design: .monospaced))
                    .foregroundColor(Color(.label))
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<25) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 6, height: CGFloat.random(in: 60...300))
                            .opacity(recorder.isRecording ? 1 : 0.35)
                    }
                }
                .frame(height: 300) // Fixed height to prevent layout shifts
//                .padding(.horizontal, 18)
//                .padding(.horizontal, 28)


                Spacer()

                Button {
                    Task {
                        let allowed = await recorder.requestPermission()
                        if !allowed {
                            permissionDenied = true
                            return
                        }

                        if recorder.isRecording {
                            recorder.stopRecording()
                            let duration = recorder.elapsed
                            let file = currentFileName
                            // جهزي الملف القادم للتسجيل القادم
                            currentFileName = AudioRecorderService.generateFileName()
                            
                            // Dismiss first, then call onFinished
                            dismiss()
                            
                            // Small delay to ensure smooth transition
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                onFinished(file, duration)
                            }
                        } else {
                            do {
                                try recorder.startRecording(fileName: currentFileName)
                            } catch {
                                // لو فشل لا تسوين crash
                            }
                        }
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 110, height: 110)
                            .shadow(radius: 10)

                        Image("Mico")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 52, height: 52) // غيروه لي حجم المايك معرف مقاسه)
                            .opacity(recorder.isRecording ? 0.9 : 1)
                    }
                }
                .padding(.bottom, 40)

            }
        } //Zstack
        .alert("Microphone permission is needed", isPresented: $permissionDenied) {
            Button("OK", role: .cancel) {}
        }
    }

    private func timeString(_ t: TimeInterval) -> String {
        let m = Int(t) / 60
        let s = Int(t) % 60
        return String(format: "%02d:%02d", m, s)
    }
}
