import SwiftUI
import UniformGrid

struct UniformGridExample: View {
    let items = Array(1...50).map { "Item \($0)" }

    var body: some View {
        ScrollView {
            UniformGridLayout(spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(6)
                }
            }
            .padding()
        }
    }
}

struct UniformGridExample_Previews: PreviewProvider {
    static var previews: some View {
        UniformGridExample()
    }
}
