import Foundation

struct ExDocument {
    var document: [ExMarkBlock]
}

struct ExMarkLine: CustomStringConvertible {
    /// 原始的行数
    var linenum: Int

    /// 行类型
    var type: LineType
    /// 行类型
    ///
    /// 其中 `title1-6` `block_start` `line` 的body不为空串
    enum LineType {
        case title1, title2, title3, title4, title5, title6
        case toc, sep
        case block_start, block_end
        case enter // 一行什么都没有 去掉\n之后是空字符串
        case line // 不是上面的几种 单纯的line
    }

    /// 内容主体 没有时为空字符串
    var body: String

    // MARK: DEBUG

    var description: String {
        return "[\(linenum)][\(type)]\(body)"
    }
}

struct ExMarkBlock: CustomStringConvertible {
    init(linenum_start: Int, linenum_end: Int,
         body: String, type: BlockType,
         style: ExMarkBlock.BlockStyle?) {
        self.linenum_start = linenum_start
        self.linenum_end = linenum_end
        self.body = body
        self.type = type
        self.style = style
    }

    /// 块所在的原始行
    var linenum_start: Int = -1
    /// 块所在的原始行
    var linenum_end: Int = -1

    var body = ""
    var title: String?
    var caption: String?

    /// 块类型
    var type: BlockType
    enum BlockType: Equatable {
        case title1, title2, title3, title4, title5, title6
        case toc, sep, enter
        case doc
        case code(language: String?, number: Bool = false), math
        case list(ordered: Bool = false), quote, table(type: TableType = .exmark, header: Bool = true)
        case paragraph(align: ParagraphAlignment? = .left) // 需要直接渲染的一行

        enum TableType {
            case exmark, csv
        }

        enum ParagraphAlignment {
            case left, center, right
        }
    }

    // MARK: 只记录当前block的style

    var style: BlockStyle?
    struct BlockStyle: CustomStringConvertible {
        var description: String {
            return "\(size) \(color) \(bgcolor)"
        }

        var size: Float = 1.0
        var color: (UInt8, UInt8, UInt8) = (0x00, 0x00, 0x00)
        var bgcolor: (UInt8, UInt8, UInt8) = (0xFF, 0xFF, 0xFF)

        static var common = BlockStyle()
    }

    // MARK: DEBUG

    var description: String {
        var bodydescription = ""
        if body == "" {
            bodydescription = ""
        } else if body == "\n" {
            bodydescription = "\n<enter>"
        } else {
            bodydescription = "\n\(body.trimmingCharacters(in: CharacterSet.newlines))"
        }

        return """
        [\(linenum_start)-\(linenum_end)] [\(type) | \(style == nil ? "nil" : style!.description)] title=\(title ?? "nil"), caption=\(caption ?? "nil")\(bodydescription)
        """
    }
}

/// 一般来说 要渲染的一行或一个条目为一个Paragraph
///
/// 也就是需要进行行内渲染的称作Paragraph
///
/// Paragraph没有style style在blcok层

// typealias??
// struct ExMarkParagraph {
//    var body: [ExMarkElement]
//
//
// }

struct ExMarkElement {
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
