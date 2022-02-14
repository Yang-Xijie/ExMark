import Foundation


struct ExMarkLine {
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
}

// MARK: DEBUG

extension ExMarkLine: CustomStringConvertible {
    var description: String {
        return "[\(linenum)][\(type)]\(body)"
    }
}
