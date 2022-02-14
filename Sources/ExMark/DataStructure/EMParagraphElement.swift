import Foundation

struct EMParagraphElement {
    var string = ""

    var type: ElementType
    enum ElementType {
        case text
        case code, math
        case image(path: String?)
        case link(path: String?), file(path: String?)
//        case anchor(id: String?), to(id: String?)
    }

    var style: [ElementStyle] = []
    enum ElementStyle: Equatable {
        case bold, italic
        case under, delete
        case size(multipler: Float) // 0 or 0.x or 1 or 5.0
        case color, bgcolor // TODO: add feature
    }
}
