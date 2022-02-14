import Foundation

func ElementsToHtml(elements: [EMParagraphElement]) -> String {
    var result = ""

    for element in elements {
        let element_html = ElementToHtml(element)
        result.append(element_html)
    }

    return result
}

func ElementToHtml(_ element: EMParagraphElement) -> String {
    var result = ""

    let element_string = element.string.replacingOccurrences(of: "\n", with: "<br>")

    switch element.type {
    case .text:
        result = element_string
        if element.style.contains(.bold) {
            result = "<strong>\(result)</strong>"
        }
        if element.style.contains(.italic) {
            result = "<em>\(result)</em>"
        }
        if element.style.contains(.under) {
            result = "<u>\(result)</u>"
        }
        if element.style.contains(.delete) {
            result = "<del>\(result)</del>"
        }

    // TODO: color bgcolor size
    case .code:
        result = "<code>\(element_string)</code>"
    case .math:
        result = "ElementToHtml TODO"

    case .image:
        result = "ElementToHtml TODO"
    case let .link(path):
        if let path = path {
            result = "<a href=\"\(path)\">\(element_string)</a>"
        } else {
            result = "\(element_string)"
        }
    case .file:
        result = "ElementToHtml TODO"
    }
    return result
}
