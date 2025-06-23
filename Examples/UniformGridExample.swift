import SwiftUI
import UniformGrid

struct UniformGridExample: View {

    var body: some View {
        ScrollView {
            UniformGridLayout(spacing: 8) {
                ForEach(0..<20) { i in
                    ZStack {
                        Color.blue.opacity(0.2)
                            .cornerRadius(8)
                        Text("Item \(i)")
                            .padding()
                    }
                }
            }
        }
    }
}

struct UniformGridExample_Previews: PreviewProvider {
    static var previews: some View {
        UniformGridExample()
    }
}
