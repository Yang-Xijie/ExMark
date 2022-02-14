import Foundation

/// a string seperated from `EMFile` using `CharaterSet.newlines`
struct EMLine {
    var linenum: Int

    var type: LineType
    enum LineType {
        // MARK: document-level

        /// title
        case title1, title2, title3, title4, title5, title6

        /// table of content
        ///
        /// `---toc---`
        case toc
        /// seperator
        ///
        /// `---sep---` or `---`
        case sep
        /// enter: nothing after trimming
        case enter

        // MARK: block-level

        /// start of a block
        ///
        /// `[[body`
        case block_start
        /// end of a block
        ///
        /// `]]`
        case block_end

        // MARK: line-level

        /// not a title/toc/sep/enter
        case line
    }

    /// `block_end`/`toc`/`sep`/`enter` have body ""
    var body: String
}

// MARK: DEBUG

extension EMLine: CustomStringConvertible {
    var description: String {
        return "[\(linenum)][\(type)]\(body)"
    }
}
