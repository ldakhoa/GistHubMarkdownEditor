//
//  File.swift
//  
//
//  Created by Khoa Le on 31/12/2022.
//

import Foundation

final class HTML {
    static let shared = HTML()

    var js: String = ""
    var baseCSS: String = ""

    private init() {
        loadCSS()
    }

    public func getHTML(with contents: String) -> String {
        return """
              <!DOCTYPE html>
              <html>
              <head>
                <style>
                \(baseCSS)
                  html, body { background: #ffffff; }
                  code { background: \(Colors.canvasSubtitle.string) !important }
                  p, h1, h2, h3, h4, h5, h6, ul, ol, dl, li, table, tr { color: \(Colors.foregroundDefault.string); }
                  table tr { background: \(Colors.accentForeground.string); }
                  table tr:nth-child(2n) { background: \(Colors.background.string); }
                  table tr th, table tr td { border-color: \(Colors.canvasSubtitle.string) }
                </style>
                <script>\(js)</script>
                <script>hljs.initHighlightingOnLoad();</script>

                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.10.0-rc/katex.min.css">
                <script src="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.10.0-rc/katex.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.10.0-rc/contrib/auto-render.min.js"></script>
              </head>
              <body>
                \(contents)

                <div>
                  <script>
                    window.scrollTo(0, 0);
                  </script>
                  <script>
                    renderMathInElement(document.body, {delimiters: [
                      {left: "$$", right: "$$", display: true},
                      {left: "$", right: "$", display: false},
                    ]});
                  </script>
                </div>
              </body>
              </html>
        """
    }

    private func loadCSS() {
        guard
            let cssFile = Bundle.module.path(forResource: "markdown", ofType: "css"),
            let cssContents = try? String(contentsOf: URL(fileURLWithPath: cssFile), encoding: .utf8)
        else { return }

        baseCSS = cssContents
    }

    private func loadJS() {
    }
}