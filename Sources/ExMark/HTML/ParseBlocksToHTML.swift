import Foundation

func ParseBlocksToHTML(_ blocks: [EMBlock]) -> String {
    var result = ""

    for block in blocks {
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
            result.append("<h1>\(htmlcontent)</h1>\n")
        case .title2:
            result.append("<h2>\(htmlcontent)</h2>\n")
        case .title3:
            result.append("<h3>\(htmlcontent)</h3>\n")
        case .title4:
            result.append("<h4>\(htmlcontent)</h4>\n")
        case .title5:
            result.append("<h5>\(htmlcontent)</h5>\n")
        case .title6:
            result.append("<h6>\(htmlcontent)</h6>\n")

       // MARK: document

        case .toc:
            // TODO: toc
            result.append("<p>---toc---</p>")
        case .sep:
            result.append("<hr>\n")
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
            result.append("<pre><code\(language == nil ? ">" : "class=\"language-\(language!)\">")\(htmlcontent)</code></pre>")
        case .math:
            // TODO: use block.body to render latex
            result.append("<pre><code>\(block.body)</code></pre>")
        case let .list(ordered):
            // TODO: render to html
            result.append("<pre><code>\(block.body)</code></pre>")
        case .quote:
            // TODO: 分级结构
            result.append(QuoteToHtml(quote: block.body))
        case let .table(type, header):
            // TODO: table
            result.append("<pre><code>\(htmlcontent)</code></pre>")

        // MARK: paragraph

        case let .paragraph(align):
            // TODO: render line-level element
            let paragraph_elements = ParseParagraphStringToElements(htmlcontent)
            let paragraph_html = ElementsToHtml(elements: paragraph_elements)

            switch align {
            case .left:
                result.append("<p align=\"left\">\(paragraph_html)</p>")
            case nil:
                result.append("<p align=\"left\">\(paragraph_html)</p>")
            case .center:
                result.append("<center>\(paragraph_html)</center>")
            case .right:
                result.append("<p align=\"right\">\(paragraph_html)</p>")
            }
        }
    }

    return result
}
