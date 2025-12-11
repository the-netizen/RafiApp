internal import SwiftUI

struct CategoryCardView: View {
    let category: MainCategory

    @State private var animate = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(radius: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color(.secondaryLabel), lineWidth: 4)
                )
            HStack {
                Spacer()

                Image(category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)   // ايقونة أصغر شوي
                    .scaleEffect(animate ? 1.06 : 1.0)
//                    .animation(.easeInOut(duration: 1.2).repeatForever(), value: animate)
//            .padding(.leading, 20)
            .padding(.horizontal, 40)

            Text(category.title)
                .font(.system(size: 24, weight: .semibold))   // خط أصغر بشوي
                .foregroundColor(Color(.label))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(width:330)
        .frame(height: 100)
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    CategoryCardView(category: .outside)
}
