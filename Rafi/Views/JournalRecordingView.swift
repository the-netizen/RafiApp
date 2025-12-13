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

    // لما يخلص تسجيل نرجع الـURL للشاشة اللي بعدها (التسمية)
    var onFinish: (URL) -> Void

    var body: some View {
        ZStack {
            Color("bgColor").ignoresSafeArea()

            VStack(spacing: 24) {
                HStack {
                    Button {
                        if recorder.isRecording {
                            _ = recorder.stopRecording() // discard URL here; this is just a back action
                        } else {
                            dismiss()
                        }
                    } label: {
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
                .padding(.top, 12)

                Spacer()

                // “Voice memos” style waveform
                WaveformView(level: recorder.meterLevel)
                    .frame(height: 140)
                    .padding(.horizontal, 24)

                Text(timeString(recorder.elapsedTime))
                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
                    .foregroundColor(.black)

                Spacer()

                Button {
                    Task {
                        if recorder.isRecording {
                            if let url = recorder.stopRecording() {
                                onFinish(url)
                            }
                        } else {
                            await recorder.startRecording()
                        }
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 92, height: 92) // ✅ حجم الدائرة

                        Image("Mico")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44) // ✅ حجم الأيقونة (اقتراح ممتاز)
                    }
                    .shadow(radius: 6)
                }
                .padding(.bottom, 28)

                if let msg = recorder.lastErrorMessage {
                    Text(msg)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }
            }
        }
    }

    private func timeString(_ t: TimeInterval) -> String {
        let total = Int(t)
        let m = total / 60
        let s = total % 60
        return String(format: "%02d:%02d", m, s)
    }
}

// Simple animated bars
struct WaveformView: View {
    var level: Float // 0...1

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            ForEach(0..<18, id: \.self) { i in
                let base = CGFloat(10 + (i % 4) * 8)
                let boost = CGFloat(level) * 80
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 6, height: max(12, base + boost * randomFactor(i)))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func randomFactor(_ i: Int) -> CGFloat {
        // ثابت عشان ما “يرتعش” بشكل عشوائي
        let factors: [CGFloat] = [0.35, 0.55, 0.8, 0.6, 0.95, 0.5, 0.75, 0.4, 0.9, 0.65, 0.85, 0.45, 0.7, 0.52, 0.88, 0.58, 0.78, 0.42]
        return factors[i % factors.count]
    }
}
