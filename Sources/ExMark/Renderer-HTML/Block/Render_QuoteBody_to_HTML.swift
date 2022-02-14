import Foundation

// FIXME: should pass EMBlock in 

func Render_QuoteBody_to_HTML(quote: String) -> String {
    var result = ""

    let lines: [String] = quote.components(separatedBy: CharacterSet.newlines)

    var i = 0

    var existing_left_quote_tag_count = 0

    while true {
        let current_line = lines[i]
        let current_layer = current_line.spaceCountAtBeginning / 4

        if i == 0 { // first line
            for _ in 0 ..< current_layer {
                result.append("<blockquote>")
            }
            existing_left_quote_tag_count += current_layer
        }

        if i < lines.count - 1 {
            let next_line: String
            let next_layer: Int

            next_line = lines[i + 1]
            next_layer = next_line.spaceCountAtBeginning / 4

            if current_layer > next_layer {
                result.append("\(current_line.trimmingCharacters(in: CharacterSet.whitespaces))")
                for _ in 0 ..< current_layer - next_layer {
                    result.append("</blockquote>")
                }
                existing_left_quote_tag_count -= current_layer - next_layer
            } else if current_layer < next_layer {
                result.append("\(current_line.trimmingCharacters(in: CharacterSet.whitespaces))")
                for _ in 0 ..< next_layer - current_layer {
                    result.append("<blockquote>")
                }
                existing_left_quote_tag_count += next_layer - current_layer
            } else { // current_layer == next_layer
                result.append("\(current_line.trimmingCharacters(in: CharacterSet.whitespaces))<br>")
            }
        } else { // last line
            result.append(current_line.trimmingCharacters(in: CharacterSet.whitespaces))
            for _ in 0 ..< existing_left_quote_tag_count {
                result.append("</blockquote>")
            }
            break
        }

        i += 1
    }

    return "<blockquote>\(result)</blockquote>"
}
