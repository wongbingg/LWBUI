// MARK: - View Debugging Tool (from. havi)

public extension View {
    func debug(_ color: Color = .blue, alignment: Alignment = .topTrailing) -> some View {
        modifier(FrameInfo(color: color, alignment: alignment))
    }
}

private struct FrameInfo: ViewModifier {
    let color: Color
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
        #if DEBUG
            .overlay(GeometryReader(content: overlay))
        #endif
    }
    
    func overlay(for geometry: GeometryProxy) -> some View {
        ZStack(alignment: alignment) {
            
            Rectangle()
                .strokeBorder(style: .init(lineWidth: 1, dash: [3]))
                .foregroundColor(color)
            
            Text("(\(Int(geometry.frame(in: .global).origin.x)), \(Int(geometry.frame(in: .global).origin.y))) \(Int(geometry.size.width))x\(Int(geometry.size.height))")
                .font(.caption2)

            .minimumScaleFactor(0.5)
            .foregroundColor(color)
            .padding(3)
            .offset(y: -20)
        }
    }
}
