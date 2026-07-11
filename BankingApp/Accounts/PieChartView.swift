import SwiftUI

public struct PieChartView: View {
    public var data: [Double]
    public var totalBalance: Double
    @Binding public var selectedIndex: Int

    public var colors: [Color] = [.blue, .green, .red]
    private let innerRadiusFactor: CGFloat = 0.8 // Kontrol etmek için iç yarıçap faktörü

    public init(data: [Double], totalBalance: Double, selectedIndex: Binding<Int>) {
        self.data = data
        self.totalBalance = totalBalance
        self._selectedIndex = selectedIndex
    }

    public func total() -> Double {
        return data.reduce(0, +)
    }

    public func startAngle(for index: Int) -> Angle {
        let sum = total()
        let start = data.prefix(index).reduce(0, +) / sum
        return Angle(degrees: start * 360)
    }

    public func endAngle(for index: Int) -> Angle {
        let sum = total()
        let end = (data.prefix(index + 1).reduce(0, +)) / sum
        return Angle(degrees: end * 360)
    }

    public func percentage(for index: Int) -> Double {
        let totalAmount = total()
        let value = data[index]
        return (value / totalAmount) * 100
    }

    public var body: some View {
        ZStack {
            ForEach(data.indices, id: \.self) { index in
                PieSliceView(startAngle: self.startAngle(for: index),
                             endAngle: self.endAngle(for: index),
                             color: self.colors[index])
                    .rotationEffect(.degrees(-90))
                    .opacity(selectedIndex == index ? 1 : 0.3)
                    .onTapGesture {
                        selectedIndex = index
                    }
            }
            
            // Gri iç daire ekleniyor
            Circle()
                .fill(Color.white)
                .frame(width: 160, height: 160)

            let currentBalance = selectedIndex == -1 ? totalBalance : data[selectedIndex]
            let currentPercentage = selectedIndex == -1 ? 100.0 : percentage(for: selectedIndex)
            
            VStack {
                Text(String(format: "%.1f%%", currentPercentage))
                    .font(.headline)
                    .foregroundColor(.black)
                Text(String(format: "%.2f ₺", currentBalance))
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
        .frame(width: 200, height: 200)
    }
}
