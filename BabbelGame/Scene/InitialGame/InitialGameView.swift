//
//  InitialGameView.swift
//  BabbelGame
//
//  Created by Abbas Sabeti on 26/02/2022.
//

import SwiftUI

struct InitialGameView<Model>: View where Model: InitialGamePresenterProtocol {

    @ObservedObject var presenter: Model
    @State private var animateValue: Double = -0.48

    init(presenter: Model) {
        self.presenter = presenter
    }

    let timer = Timer.publish(every: 0.004, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {

                provideWordView(presenter.word, frameSize: geometry.size)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)

                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        providePlayer(index: 0)
                        Spacer()
                        providePlayer(index: 1)
                    }
                    .frame(width: geometry.size.width)
                    Spacer()
                    HStack(alignment: .center) {
                        providePlayer(index: 2)
                        Spacer()
                        providePlayer(index: 3)
                    }
                    .frame(width: geometry.size.width)
                }
                .frame(height: geometry.size.height)

                provideResultView(presenter.winner, frameSize: geometry.size)
            }
        }
        .onAppear {
            presenter.startGame()
        }
    }

    func providePlayer(index: Int) -> some View {
        let angle: Double = [1, 3].contains(index) ? -90 : 90
        return PlayerView(user: presenter.players[index], angle: angle, action: {
            guard presenter.winner == nil else {return}
            animateValue = -0.48
            presenter.playFor(userIndex: index)
        })
    }

    private func provideWordView(_ word: GameWord?, frameSize: CGSize) -> some View {
        guard word != nil else {return AnyView(EmptyView())}
        let original = word!.original
        let meaning = word!.lastShownMeaning
        return AnyView(
            ZStack {
                VStack {
                    Text(original)
                        .font(.system(size: 27))
                        .fontWeight(.heavy)
                }
                VStack(alignment: .center) {
                    Text(meaning)
                    .font(.system(size: 21))
                    .fontWeight(.bold)
                    .frame(alignment: .center)
                    .offset(x: 0, y: animateValue * frameSize.height)
                    .opacity(animateValue + 0.5)
                }
                .onAppear {
                    startGameAnimation()
                }
                .onReceive(timer) { _ in
                    guard animateValue < 0.5 && presenter.winner == nil else {
                        animateValue = -0.5
                        return
                    }
                    animateValue += 0.002
                }
            }
        )
    }

    private func provideResultView(_ winner: Player?, frameSize: CGSize) -> some View {
        guard let winner = winner else {return AnyView(EmptyView())}

        return AnyView(
            VStack {
                Text("\(winner.name) Wins!")
                Text("Net Score: \(winner.getNetScore())")
                Button("Rematch") {
                    presenter.resetGame()
                    startGameAnimation()
                }
                .padding([.leading, .trailing], 8)
                .background(Color.white)
                .cornerRadius(5)
                .padding([.top], 30)
            }
                .frame(width: 250, height: 150, alignment: .center)
                .background(Color.gray)
                .cornerRadius(5)
        )
    }

    private func startGameAnimation() {
        animateValue = -0.5
    }
}
