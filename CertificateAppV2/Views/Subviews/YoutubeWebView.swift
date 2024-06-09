import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURLString = "https://www.youtube.com/embed/\(videoID)"
        if let url = URL(string: embedURLString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
