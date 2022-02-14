import Foundation

func Render_Document_to_HTML(_ document: EMDocument) -> HTML {
    var result: HTML = ""

    for block in document {
        let htmlcontent: String = block.body
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "\'", with: "&apos;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\n", with: "<br>")

        switch block.type {
        // MARK: title

        // TODO: add id and anchor
        case .title1:
            result.append("<h1>\(htmlcontent)</h1>")
        case .title2:
            result.append("<h2>\(htmlcontent)</h2>")
        case .title3:
            result.append("<h3>\(htmlcontent)</h3>")
        case .title4:
            result.append("<h4>\(htmlcontent)</h4>")
        case .title5:
            result.append("<h5>\(htmlcontent)</h5>")
        case .title6:
            result.append("<h6>\(htmlcontent)</h6>")

       // MARK: document

        case .toc:
            // TODO: toc
            result.append("<p>---toc---</p>")
        case .sep:
            result.append("<hr>")
        case .doc:
            // TODO: doc
            result.append("<pre><code>\(block.body)</code></pre>")
        case .enter:
            result.append("<br>")

        // MARK: blocks

        case let .code(language, number):
            if number == true {
                // TODO: 每一行前面加上序号
            }
            // TODO: add js
            result.append("<pre><code\(language == nil ? ">" : " class=\"language-\(language!)\">")\(htmlcontent)</code></pre>")
        case .math:
            // TODO: use block.body to render latex
            result.append("<pre><code>\(block.body)</code></pre>")
        case let .list(ordered):
            // TODO: render to html
            result.append("<pre><code>\(block.body)</code></pre>")
        case .quote:
            result.append(Render_QuoteBody_to_HTML(quote: block.body))
        case let .table(type, header):
            // TODO: table
            result.append("<pre><code>\(htmlcontent)</code></pre>")

        // MARK: paragraph

        case let .paragraph(align):
            // TODO: render line-level element
            let paragraph_elements = Parse_ParagraphBody_to_Paragraph(htmlcontent)
            let paragraph_html = Render_Paragraph_to_HTML(elements: paragraph_elements)

            switch align {
            case .left:
                result.append("<p>\(paragraph_html)</p>")
            case nil:
                result.append("<p>\(paragraph_html)</p>")
            case .center:
                result.append("<center>\(paragraph_html)</center>")
            case .right:
                result.append("<p align=\"right\">\(paragraph_html)</p>")
            }
        }
    }

    return result
}
