import SwiftUI

enum AppScreen {
    case loading, home, level, game
}

struct GameRootView: View {
    @State private var screen: AppScreen = .loading

    var body: some View {
        ZStack {
            switch screen {
            case .loading:
                LoadingView {
                    withAnimation(.easeInOut(duration: 0.35)) { screen = .home }
                }
            case .home:
                HomeView {
                    withAnimation(.easeInOut(duration: 0.3)) { screen = .level }
                }
            case .level:
                LevelView {
                    withAnimation(.easeInOut(duration: 0.3)) { screen = .game }
                } onHome: {
                    withAnimation(.easeInOut(duration: 0.3)) { screen = .home }
                }
            case .game:
                GameView {
                    withAnimation(.easeInOut(duration: 0.3)) { screen = .level }
                }
            }
        }
    }
}

struct LoadingView: View {
    let onDone: () -> Void
    @State private var progress: CGFloat = 0.08

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.95), .cyan.opacity(0.38), .white],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 18) {
                Spacer()
                Text("BUS")
                    .font(.system(size: 78, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                    )
                    .shadow(color: .black.opacity(0.35), radius: 1, y: 7)

                Text("Traffic")
                    .font(.system(size: 64, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom)
                    )
                    .shadow(color: .blue.opacity(0.8), radius: 1, y: 7)

                Text("Fever!")
                    .font(.system(size: 48, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .blue.opacity(0.8), radius: 1, y: 5)

                BusIllustration()
                    .frame(height: 250)

                Spacer()

                ZStack(alignment: .leading) {
                    Capsule().fill(.black.opacity(0.35)).frame(width: 260, height: 18)
                    Capsule().fill(.green).frame(width: 260 * progress, height: 18)
                }
                .padding(.bottom, 30)
            }
            .padding()

            VStack {
                Spacer()
                Text("1.0.0")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.65))
                    .padding(.bottom, 7)
            }
        }
        .task {
            withAnimation(.linear(duration: 1.5)) { progress = 1 }
            try? await Task.sleep(for: .seconds(1.65))
            onDone()
        }
    }
}

struct HomeView: View {
    let start: () -> Void

    var body: some View {
        ZStack {
            CityBackground()

            VStack(spacing: 0) {
                HStack {
                    CircleButton(symbol: "gearshape.fill")
                    CircleButton(symbol: "cat.fill")
                    Spacer()
                    HStack(spacing: 6) {
                        Text("🪙").font(.title2)
                        Text("490").font(.title3.bold())
                        Circle()
                            .fill(.green)
                            .frame(width: 34, height: 34)
                            .overlay(Text("+").font(.title.bold()).foregroundStyle(.white))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.75), in: Capsule())
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                HStack {
                    Circle()
                        .fill(.pink.opacity(0.9))
                        .frame(width: 62, height: 62)
                        .overlay(Text("B").font(.largeTitle.bold()).foregroundStyle(.white))
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Chào mừng bạn trở lại")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.85))
                        Text("BaConMuc")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .padding(10)
                .background(.blue.opacity(0.82), in: Capsule())
                .padding(.horizontal, 52)
                .padding(.top, 5)

                HStack {
                    SideAction(title: "ADs", subtitle: "No Ads", icon: "play.rectangle.fill")
                    Spacer()
                    SideAction(title: "🔒", subtitle: "Streak", icon: "flame.fill")
                }
                .padding(.horizontal, 14)
                .padding(.top, 24)

                Spacer()

                VStack(spacing: 12) {
                    Bus3D(color: .red)
                        .frame(height: 270)
                    Button(action: start) {
                        VStack(spacing: 0) {
                            Text("HARD")
                                .font(.title2.bold())
                            Text("LEVEL 8")
                                .font(.system(size: 40, weight: .black, design: .rounded))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(colors: [.red, .orange.opacity(0.9)],
                                           startPoint: .top, endPoint: .bottom),
                            in: RoundedRectangle(cornerRadius: 28)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 28).stroke(.white, lineWidth: 4))
                        .shadow(radius: 7, y: 5)
                    }
                    .padding(.horizontal, 48)
                }

                Spacer()

                HStack {
                    BottomTab(icon: "storefront.fill", title: "SHOP")
                    BottomTab(icon: "house.fill", title: "HOME", active: true)
                    BottomTab(icon: "lock.fill", title: "EVENT")
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 8)
            }
        }
    }
}

struct LevelView: View {
    let play: () -> Void
    let onHome: () -> Void

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    CircleButton(symbol: "arrow.left", action: onHome)
                    Spacer()
                    Text("HARD\nLEVEL 8")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 28, weight: .black, design: .rounded))
                    Spacer()
                    CircleButton(symbol: "pause.fill")
                }
                .padding()

                PassengerTrack()
                    .padding(.horizontal, 12)
                    .frame(height: 280)

                HStack(spacing: 12) {
                    Text("VIP")
                        .font(.headline.bold())
                        .foregroundStyle(.yellow)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 22)
                        .background(.orange.opacity(0.9), in: RoundedRectangle(cornerRadius: 16))

                    ForEach(0..<4, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.gray.opacity(0.25))
                            .frame(height: 72)
                    }

                    ForEach(0..<3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(style: StrokeStyle(lineWidth: 3, dash: [7]))
                            .foregroundStyle(.blue.opacity(0.5))
                            .frame(height: 72)
                            .overlay(Text("+").font(.title.bold()).foregroundStyle(.green))
                    }
                }
                .padding(.horizontal, 8)

                Spacer()

                BusPuzzlePreview()
                    .padding(.horizontal, 16)

                HStack(spacing: 18) {
                    PowerButton(emoji: "🚌")
                    PowerButton(emoji: "↪️")
                    PowerButton(emoji: "🚕")
                    PowerButton(emoji: "🛍️")
                }
                .padding(.vertical, 12)

                Button(action: play) {
                    Text("START LEVEL")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(.blue.gradient, in: Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 10)
            }
        }
    }
}

struct GameView: View {
    let back: () -> Void
    @State private var buses = BusModel.makeDemo()
    @State private var slots: [BusColor?] = Array(repeating: nil, count: 6)
    @State private var moves = 0

    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()

            VStack(spacing: 8) {
                HStack {
                    CircleButton(symbol: "arrow.counterclockwise", action: {
                        buses = BusModel.makeDemo()
                        slots = Array(repeating: nil, count: 6)
                        moves = 0
                    })
                    Spacer()
                    VStack(spacing: 0) {
                        Text("HARD")
                            .font(.headline.bold())
                            .foregroundStyle(.red)
                        Text("LEVEL 8")
                            .font(.title.bold())
                    }
                    Spacer()
                    CircleButton(symbol: "pause.fill")
                }
                .padding(.horizontal)

                BoardView(buses: buses) { id in
                    selectBus(id)
                }
                .padding(.horizontal, 10)

                SlotBar(slots: slots)

                Text("Moves: \(moves)")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)

                HStack(spacing: 18) {
                    PowerButton(emoji: "🚌")
                    PowerButton(emoji: "↪️")
                    PowerButton(emoji: "🚕")
                    PowerButton(emoji: "🛍️")
                }
                .padding(.bottom, 8)
            }
        }
    }

    private func selectBus(_ id: Int) {
        guard let index = buses.firstIndex(where: { $0.id == id && !$0.removed }) else { return }
        guard let slot = slots.firstIndex(where: { $0 == nil }) else { return }

        slots[slot] = buses[index].color
        buses[index].removed = true
        moves += 1

        // Three matching buses clear.
        if slot >= 2,
           slots[slot - 2] == slots[slot],
           slots[slot - 1] == slots[slot] {
            slots[slot - 2] = nil
            slots[slot - 1] = nil
            slots[slot] = nil
        }
    }
}

enum BusColor: CaseIterable {
    case red, yellow, green, blue, pink, cyan, orange, purple, brown

    var color: Color {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .pink: return .pink
        case .cyan: return .cyan
        case .orange: return .orange
        case .purple: return .purple
        case .brown: return .brown
        }
    }
}

struct BusModel: Identifiable {
    let id: Int
    let color: BusColor
    let direction: String
    var removed: Bool = false

    static func makeDemo() -> [BusModel] {
        let colors: [BusColor] = [
            .green,.yellow,.cyan,.pink,.yellow,.green,.brown,.pink,.red,
            .blue,.purple,.yellow,.red,.green,.cyan,.orange,.pink,.blue,
            .green,.red,.yellow,.purple,.cyan,.pink,.orange,.green,.red,
            .blue,.yellow,.pink,.cyan,.green,.orange,.purple,.red,.blue
        ]
        return colors.enumerated().map {
            BusModel(id: $0.offset, color: $0.element, direction: ["↑","→","←","↓"][$0.offset % 4])
        }
    }
}

struct BoardView: View {
    let buses: [BusModel]
    let tap: (Int) -> Void

    var body: some View {
        GeometryReader { geo in
            let columns = 5
            let rows = 8
            let w = (geo.size.width - 24) / CGFloat(columns)
            let h = (geo.size.height - 28) / CGFloat(rows)

            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white.opacity(0.45))

                ForEach(buses) { bus in
                    if !bus.removed {
                        let row = bus.id / columns
                        let col = bus.id % columns
                        MiniBus(color: bus.color.color, direction: bus.direction)
                            .frame(width: w * 0.82, height: h * 0.82)
                            .position(
                                x: 12 + w * CGFloat(col) + w / 2,
                                y: 14 + h * CGFloat(row) + h / 2
                            )
                            .onTapGesture { tap(bus.id) }
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
        }
        .frame(height: 500)
    }
}

struct SlotBar: View {
    let slots: [BusColor?]
    var body: some View {
        HStack(spacing: 7) {
            ForEach(Array(slots.enumerated()), id: \.offset) { _, value in
                RoundedRectangle(cornerRadius: 14)
                    .fill(value?.color ?? .gray.opacity(0.18))
                    .frame(height: 62)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.white, lineWidth: 3)
                    )
            }
        }
        .padding(.horizontal, 10)
    }
}

struct MiniBus: View {
    let color: Color
    let direction: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(color.gradient)
                .shadow(radius: 3, y: 2)
            VStack(spacing: 2) {
                Text("● ●")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white.opacity(0.9))
                Text(direction)
                    .font(.system(size: 24, weight: .black))
                    .foregroundStyle(.white)
            }
        }
    }
}

struct PassengerTrack: View {
    let colors: [Color] = [.blue, .orange, .green, .pink, .cyan, .yellow, .green, .blue, .pink, .orange, .green, .blue, .pink, .green]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(.white)
                .shadow(radius: 5)
            VStack(spacing: 5) {
                HStack {
                    ForEach(0..<7, id: \.self) { i in
                        Passenger(color: colors[i % colors.count])
                    }
                }
                HStack {
                    ForEach(7..<14, id: \.self) { i in
                        Passenger(color: colors[i % colors.count])
                    }
                }
            }
            .padding(18)
        }
    }
}

struct Passenger: View {
    let color: Color
    var body: some View {
        Circle()
            .fill(color.gradient)
            .frame(width: 42, height: 42)
            .overlay(Circle().stroke(.white.opacity(0.4), lineWidth: 2))
    }
}

struct BusPuzzlePreview: View {
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 7), count: 5), spacing: 8) {
            ForEach(0..<30, id: \.self) { i in
                MiniBus(color: BusColor.allCases[i % BusColor.allCases.count].color,
                        direction: ["↑","→","←","↓"][i % 4])
                    .frame(height: 42)
            }
        }
    }
}

struct BusIllustration: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.yellow.gradient)
                .frame(width: 250, height: 130)
                .shadow(radius: 8, y: 7)
            RoundedRectangle(cornerRadius: 18)
                .fill(.blue.opacity(0.35))
                .frame(width: 190, height: 55)
                .offset(y: -15)
            HStack(spacing: 16) {
                ForEach(0..<5, id: \.self) { i in
                    Circle().fill([Color.pink,.cyan,.green,.orange,.purple][i])
                        .frame(width: 30, height: 30)
                        .offset(y: CGFloat((i % 2) * -8))
                }
            }
            .offset(y: -38)
        }
    }
}

struct Bus3D: View {
    let color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(color.gradient)
                .frame(width: 260, height: 230)
                .shadow(radius: 8, y: 9)
            RoundedRectangle(cornerRadius: 15)
                .fill(.black.opacity(0.35))
                .frame(width: 205, height: 75)
                .offset(y: -35)
            RoundedRectangle(cornerRadius: 14)
                .fill(.white.opacity(0.8))
                .frame(width: 145, height: 22)
                .offset(y: 42)
            HStack {
                Circle().fill(.white.opacity(0.9)).frame(width: 32)
                Spacer()
                Circle().fill(.white.opacity(0.9)).frame(width: 32)
            }
            .padding(.horizontal, 32)
            .offset(y: 82)
        }
    }
}

struct CityBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.95), .cyan.opacity(0.45), .white],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Spacer().frame(height: 230)
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(0..<11, id: \.self) { i in
                        Rectangle()
                            .fill(.white.opacity(0.48))
                            .frame(width: 30 + CGFloat(i % 3) * 12,
                                   height: 180 + CGFloat((i * 31) % 140))
                    }
                }
                Spacer()
            }

            VStack {
                HStack {
                    Text("☁️").font(.system(size: 70))
                    Spacer()
                    Text("☁️").font(.system(size: 90))
                }
                .padding(.horizontal, 10)
                Spacer()
            }
        }
    }
}

struct CircleButton: View {
    let symbol: String
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.title2.bold())
                .foregroundStyle(.white)
                .frame(width: 52, height: 52)
                .background(.blue.gradient, in: Circle())
                .overlay(Circle().stroke(.white, lineWidth: 3))
                .shadow(radius: 3)
        }
    }
}

struct SideAction: View {
    let title: String
    let subtitle: String
    let icon: String
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: icon)
                .font(.system(size: 42, weight: .black))
                .foregroundStyle(.white)
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.white)
            Text(subtitle)
                .font(.headline.bold())
                .foregroundStyle(.white)
        }
        .padding(8)
        .background(.purple.opacity(0.9), in: RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.8), lineWidth: 2))
    }
}

struct BottomTab: View {
    let icon: String
    let title: String
    var active = false
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon).font(.title2.bold())
            Text(title).font(.caption.bold())
        }
        .foregroundStyle(active ? .white : .white.opacity(0.55))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(active ? .indigo : .indigo.opacity(0.75), in: RoundedRectangle(cornerRadius: 18))
    }
}

struct PowerButton: View {
    let emoji: String
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Circle()
                .fill(.blue.gradient)
                .frame(width: 74, height: 74)
                .overlay(Circle().stroke(.white.opacity(0.8), lineWidth: 3))
                .shadow(radius: 3)
            Text(emoji).font(.system(size: 34))
            Circle()
                .fill(.red)
                .frame(width: 25, height: 25)
                .overlay(Text("+").bold().foregroundStyle(.white))
                .offset(x: 3, y: -3)
        }
    }
}

#Preview {
    GameRootView()
}
