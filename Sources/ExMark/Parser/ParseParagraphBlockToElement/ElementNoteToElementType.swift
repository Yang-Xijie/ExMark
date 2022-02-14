import Foundation

/// If there are more than one types, use the first one.
func ElementNoteToElementType(_ element_note: String) -> EMParagraphElement.ElementType {
    let result: EMParagraphElement.ElementType

    if element_note == "" {
        return .text
    } else if element_note.contains("code") {
        result = .code
    } else if element_note.contains("math") {
        result = .math
    } else if element_note.contains("image") {
        if let path = element_note.getSubstringBy(reg: "(?<=image ).*(?=,)") { // Check `,`. If first check `)`, it might be greedy.
            result = .image(path: path)
        } else if let path = element_note.getSubstringBy(reg: "(?<=image ).*") {
            result = .image(path: path)
        } else {
            result = .image(path: nil)
        }
    } else if element_note.contains("file") {
        if let path = element_note.getSubstringBy(reg: "(?<=file ).*(?=,)") { // Check `,`. If first check `)`, it might be greedy.
            result = .file(path: path)
        } else if let path = element_note.getSubstringBy(reg: "(?<=file ).*") {
            result = .file(path: path)
        } else {
            result = .file(path: nil)
        }
    } else if element_note.contains("link") {
        if let path = element_note.getSubstringBy(reg: "(?<=link ).*(?=,)") { // Check `,`. If first check `)`, it might be greedy.
            result = .link(path: path)
        } else if let path = element_note.getSubstringBy(reg: "(?<=link ).*") {
            result = .link(path: path)
        } else {
            result = .link(path: nil)
        }
    } else {
        result = .text
    }
    // TODO: anchor to

    return result
}
