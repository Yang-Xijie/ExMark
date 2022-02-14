import Foundation

func Parse_ParagraphBody_to_Paragraph(_ paragraph: EMParagraphBody) -> EMParagraph {
    var result: EMParagraph = []

    var i = 0
    var c: Character

    while true {
        // MARK: one element

        var element_body = ""
        var element_note = ""

        if i < paragraph.count {
            c = paragraph[paragraph.index(paragraph.startIndex, offsetBy: i)]
        } else {
            break
        }

        if c == "[" { // MARK: elements except text
            var element_done_flag = false
            i += 1
            while !element_done_flag {
                if i < paragraph.count {
                    c = paragraph[paragraph.index(paragraph.startIndex, offsetBy: i)]
                } else { // start with [ to end of the line
                    result.append(.init(string: "[\(element_body)", type: .text, style: Parse_ElementNote_to_ElementStyles(element_note)))
                    break
                }

                if c == "]" {
                    i += 1

                    if i < paragraph.count {
                        c = paragraph[paragraph.index(paragraph.startIndex, offsetBy: i)]
                    } else { // [ ... ]EOL
                        result.append(.init(string: "[\(element_body)]", type: .text, style: Parse_ElementNote_to_ElementStyles(element_note)))
                        break
                    }

                    // find element
                    if c == "(" { // [ ... ](
                        i += 1

                        while true {
                            if i < paragraph.count {
                                c = paragraph[paragraph.index(paragraph.startIndex, offsetBy: i)]
                            } else {
                                break
                            }

                            if c == ")" {
                                result.append(.init(string: "\(element_body)", type: Parse_ElementNote_to_ElementType(element_note), style: Parse_ElementNote_to_ElementStyles(element_note)))
                                element_done_flag = true
                                i += 1
                                break
                            } else { // [ ... ]( ...
                                element_note.append(c)
                                i += 1
                            }
                        }
                    } else { // just [ ... ]xxx
                        result.append(.init(string: "[\(element_body)]", type: .text, style: Parse_ElementNote_to_ElementStyles(element_note)))
                        break
                    }
                } else { // [ ...
                    element_body.append(c)
                    i += 1
                }
            }
        } else { // MARK: text
            while true {
                if i < paragraph.count {
                    c = paragraph[paragraph.index(paragraph.startIndex, offsetBy: i)]
                } else {
                    result.append(EMParagraphElement(
                        string: element_body, type: .text, style: Parse_ElementNote_to_ElementStyles(element_note)
                    ))
                    break
                }

                if c == "[" {
                    result.append(EMParagraphElement(
                        string: element_body, type: .text, style: Parse_ElementNote_to_ElementStyles(element_note)
                    ))
                    break // no ++
                } else {
                    element_body.append(c)
                    i += 1
                }
            }
        }

        element_body = ""
        element_note = ""
    }

    return result
}
