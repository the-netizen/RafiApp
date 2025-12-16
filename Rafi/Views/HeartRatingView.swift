//
//  HeartRatingView.swift
//  Rafi
//
//  Created by Noor Alhassani on 24/06/1447 AH.
//

internal import SwiftUI

struct HeartRatingView: View {
    @Binding var rating: Int   // 1...5 (changed to binding for interactivity)
    let size: CGFloat
    
    @State private var orbPosition: CGFloat = 0
    @State private var isDragging: Bool = false
    
    private let heartSpacing: CGFloat = 8
    
    private func heartAssetName(for index: Int) -> String {
        // Hearts from most filled (heart100) to least filled (heart0)
        switch index {
        case 1: return "heart100"  // First heart - fully filled
        case 2: return "heart75"   // Second heart - 75% filled
        case 3: return "heart50"   // Third heart - 50% filled
        case 4: return "heart25"   // Fourth heart - 25% filled
        case 5: return "heart0"    // Fifth heart - empty
        default: return "heart0"
        }
    }
    
    // Computed properties
    private var heartSize: CGFloat {
        size * 0.65 // Even smaller hearts
    }
    
    private var orbSize: CGFloat {
        heartSize * 1.35 // Bigger than hearts to frame them
    }
    
    private var totalWidth: CGFloat {
        CGFloat(5) * heartSize + CGFloat(4) * heartSpacing
    }
    
    private func targetOrbPosition(for rating: Int) -> CGFloat {
        let heartIndex = CGFloat(rating - 1)
        let heartCenter = heartIndex * (heartSize + heartSpacing) + (heartSize / 2)
        return heartCenter - (totalWidth / 2)
    }

    var body: some View {
        HStack { // Centering wrapper
            Spacer()
            
            GeometryReader { geometry in
                ZStack {
                    // Static hearts layer - absolutely no animations or conditional rendering
                    HStack(spacing: heartSpacing) {
                        ForEach(1...5, id: \.self) { i in
                            Button {
                                // Tap to select heart
                                rating = i
                                
                                // Haptic feedback for tap
                                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                                impactFeedback.impactOccurred()
                            } label: {
                                Image(heartAssetName(for: i))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: heartSize, height: heartSize)
                                    .scaleEffect(i == rating ? 1.3 : 1.0) // Increased zoom effect for smaller hearts
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: rating)
                    
                    // Independent sliding orb - moves smoothly without affecting hearts
                    Circle()
                        .stroke(.primary, lineWidth: 2.5)
                        .frame(width: orbSize, height: orbSize)
                        .offset(x: isDragging ? orbPosition : targetOrbPosition(for: rating))
                        .scaleEffect(isDragging ? 1.1 : 1.0)
                        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8), value: isDragging)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: rating)
                        .allowsHitTesting(false)
                }
                .frame(width: totalWidth, height: heartSize)
                .onAppear {
                    orbPosition = targetOrbPosition(for: rating)
                }
            }
            .frame(width: totalWidth, height: heartSize)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 3)
                    .onChanged { value in
                        handleDragChange(value, in: totalWidth)
                    }
                    .onEnded { _ in
                        handleDragEnd()
                    }
            )
            
            Spacer()
        }
        .frame(height: heartSize)
    }
    
    // MARK: - Smooth Slider Logic
    
    private func handleDragChange(_ value: DragGesture.Value, in containerWidth: CGFloat) {
        isDragging = true
        
        // Calculate smooth continuous position
        let dragX = value.location.x
        let centerOffset = containerWidth / 2
        
        // Update orb position smoothly without snapping
        orbPosition = dragX - centerOffset
        
        // Clamp orb position to valid range
        let minPosition = -(containerWidth / 2) + (heartSize / 2)
        let maxPosition = (containerWidth / 2) - (heartSize / 2)
        orbPosition = max(minPosition, min(maxPosition, orbPosition))
        
        // Calculate which heart the orb is closest to
        let relativePosition = orbPosition + centerOffset
        let heartIndex = Int(round(relativePosition / (heartSize + heartSpacing)))
        let newRating = max(1, min(5, heartIndex + 1))
        
        if newRating != rating {
            rating = newRating
            
            // Light haptic feedback for smooth dragging
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
        }
    }
    
    private func handleDragEnd() {
        // Smooth transition back to target position
        isDragging = false
        orbPosition = targetOrbPosition(for: rating)
    }
}

#Preview {
    @State var rating = 1
    
    return VStack(spacing: 30) {
        HeartRatingView(rating: $rating, size: 40)
        
        Text("Current Rating: \(rating)")
            .font(.title2)
        
        HStack {
            ForEach(1...5, id: \.self) { r in
                Button("\(r)") {
                    rating = r
                }
                .padding()
                .background(rating == r ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
    }
    .padding()
}
