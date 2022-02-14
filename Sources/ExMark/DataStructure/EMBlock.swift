import Foundation

struct EMBlock {
    init(linenum_start: Int, linenum_end: Int,
         body: String, type: BlockType,
         style: EMBlock.BlockStyle?) {
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
}

// MARK: DEBUG

extension EMBlock: CustomStringConvertible {
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
