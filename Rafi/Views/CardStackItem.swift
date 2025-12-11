internal import SwiftUI

struct CardStackItem: View {
    let card: ChallengeCard

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 330, height: 440)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 8)

            VStack(spacing: 16) {
                HStack {
                    Text(card.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 22)
                .padding(.top, 20)

                Text(card.description)
                    .font(.system(size: 18))
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.horizontal, 22)

                Spacer()

                Image(card.difficultyImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                    .opacity(0.22)
                    .padding(.bottom, 20)

                Spacer()

                NavigationLink(value: card) {
                    Text("ابدأ")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 60)
                        .padding(.vertical, 12)
                        .background(.button)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.bottom, 22)
            }
            .frame(width: 330, height: 440)
        }
    }
}

struct CardStackItem_Previews: PreviewProvider {
    static var previews: some View {
        CardStackItem(
            card: ChallengeCard(difficultyImageName: "String", titleKey: "String", descriptionKey: "String", conditionsKey: "String")
            )
        .environment(\.layoutDirection, .rightToLeft)
    }
}
