import Foundation

func ElementNoteToElementStyle(_ element_note: String) -> [EMParagraphElement.ElementStyle] {
    var result: [EMParagraphElement.ElementStyle] = []

    if element_note.contains("bold") {
        result.append(.bold)
    }
    if element_note.contains("italic") {
        result.append(.italic)
    }
    if element_note.contains("under") {
        result.append(.under)
    }
    if element_note.contains("delete") {
        result.append(.delete)
    }

    if element_note.contains("size") {
        let multiplier = Float(element_note.getSubstringBy(reg: "(?<=link )[0-9\\.]*(?=[)])") ?? "") ?? 0.0
        result.append(.size(multipler: multiplier))
    }

//    if element_note.contains("color"){
//        result.append(.color)
//    }
//    if element_note.contains("bgcolor"){
//        result.append(.bgcolor)
//    }
    return result
}
