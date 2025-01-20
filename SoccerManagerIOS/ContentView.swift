import SwiftUI

struct ContentView: View {
    @State private var circles: [CircleData] = [] // Array to hold all circles
    @State private var dragOffset = CGSize.zero // Store the drag offset
    
    var body: some View {
        ZStack {
            // Add a "+" button at the top right corner of the screen
            VStack {
                HStack {
                    Spacer() // Push the button to the right
                    Button(action: {
                        // Add a new circle with a sequential number
                        let newNumber = circles.count + 1
                        let newCircle = CircleData(id: UUID(), position: CGSize(width: 100, height: 100), number: newNumber)
                        circles.append(newCircle)
                    }) {
                        Text("+")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            .shadow(radius: 10)
                    }
                    .padding()
                }
                Spacer()
            }

            // Iterate over all circles and display them
            ForEach(circles.sorted { $0.id.uuidString > $1.id.uuidString }, id: \.id) { circle in
                Circle()
                    .frame(width: 100, height: 100) // Circle size
                    .foregroundColor(.blue) // Circle color
                    .overlay(
                        Text("\(circle.number)") // Display the circle's number
                            .foregroundColor(.white) // Text color
                            .font(.largeTitle) // Font size
                    )
                    .position(x: circle.position.width, y: circle.position.height) // Position the circle
                    .gesture(
                        DragGesture() // Add a drag gesture
                            .onChanged { value in
                                // Update the position relative to the drag offset
                                if let index = circles.firstIndex(where: { $0.id == circle.id }) {
                                    circles[index].position = CGSize(
                                        width: value.location.x - dragOffset.width,
                                        height: value.location.y - dragOffset.height
                                    )
                                }
                            }
                            .onEnded { value in
                                // Update the drag offset to keep the circle at the final drag position
                                if let index = circles.firstIndex(where: { $0.id == circle.id }) {
                                    dragOffset = CGSize(
                                        width: value.location.x - circles[index].position.width,
                                        height: value.location.y - circles[index].position.height
                                    )
                                }
                            }
                    )
                    .overlay(
                        Circle().stroke(Color.black, lineWidth: 2) // Add a black outline
                    )
            }
        }
    }
}

// Data model to represent each circle
struct CircleData {
    var id: UUID
    var position: CGSize
    var number: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
