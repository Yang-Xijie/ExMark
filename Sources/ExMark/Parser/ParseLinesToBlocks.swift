import Foundation

func ParseLinesToBlocks(_ lines: [ExMarkLine]) -> [ExMarkBlock] {
    var result: [ExMarkBlock] = []

    var docHasAppeared = false

    var current_index = 0
    var current_line: ExMarkLine

    while current_index < lines.count {
        current_line = lines[current_index]

        // MARK: - one line

        if current_line.type == .title1 || current_line.type == .title2 || current_line.type == .title3 || current_line.type == .title4 || current_line.type == .title5 || current_line.type == .title6 ||
            current_line.type == .toc || current_line.type == .sep
        {
            var block_type: ExMarkBlock.BlockType
            switch current_line.type {
            case .title1:
                block_type = .title1
            case .title2:
                block_type = .title2
            case .title3:
                block_type = .title3
            case .title4:
                block_type = .title4
            case .title5:
                block_type = .title5
            case .title6:
                block_type = .title6
            case .toc:
                block_type = .toc
            case .sep:
                block_type = .sep
            default:
                fatalError()
            }
            result.append(ExMarkBlock(
                linenum_start: current_line.linenum, linenum_end: current_line.linenum,
                body: current_line.body,
                type: block_type,
                style: nil // title1-6 toc sep don't need style
            ))
        } else {
            switch current_line.type {
            case .enter:
                result.append(ExMarkBlock(
                    linenum_start: current_line.linenum, linenum_end: current_line.linenum,
                    body: "\n",
                    type: .paragraph(align: nil),
                    style: nil // enter don't need style
                ))
            case .line:
                result.append(ExMarkBlock(
                    linenum_start: current_line.linenum, linenum_end: current_line.linenum,
                    body: current_line.body,
                    type: .paragraph(align: nil),
                    style: nil // line don't need style, if user wants to set style to line, use line-level grammar or use [[paragraph, style ... ]]
                ))

            // MARK: - block

            case .block_start:
                var block_linenum_start: Int
                var block_linenum_end: Int
                var block_type: ExMarkBlock.BlockType
                var block_style: ExMarkBlock.BlockStyle?

                let note = current_line.body

                // MARK: doc

                if note.contains("doc") {
                    block_type = .doc
                    block_style = nil
                }

                // MARK: code

                else if note == "" {
                    block_type = .code(language: nil)
                    block_style = nil // TODO: size bgcolor
                } else if note.contains("code") {
                    let language = note.getSubstringBy(reg: "(?<=code )[a-zA-Z0-9]+")

                    block_type = .code(language: language, number: note.contains("number") || note.contains("-n"))
                    block_style = nil // TODO: size bgcolor
                }

                // MARK: math

                else if note.contains("math") {
                    block_type = .math
                    block_style = nil // TODO: size color bgcolor
                }

                // MARK: list

                else if note.contains("list") {
                    block_type = .list(ordered: note.contains("order") ? true : false)
                    block_style = nil // TODO: size color bgcolor
                }

                // MARK: quote

                else if note.contains("quote") {
                    block_type = .quote
                    block_style = nil // TODO: size color bgcolor
                }

                // MARK: table

                else if note.contains("table") {
                    block_type = .table(type: note.contains("csv") ? .csv : .exmark,
                                        header: !note.contains("noheader"))
                    block_style = nil // TODO: size color bgcolor
                }

                // MARK: paragraph

                else if note.contains("paragraph") {
                    if note.contains("center") {
                        block_type = .paragraph(align: .center)
                    } else if note.contains("right") {
                        block_type = .paragraph(align: .right)
                    } else {
                        block_type = .paragraph(align: .left)
                    }
                    block_style = nil // TODO: size color bgcolor bold italic delete under
                } else {
                    block_type = .paragraph(align: .left)
                }

                block_linenum_start = current_index + 1
                block_linenum_end = current_index
                var block_body = ""
                // get block body
                while current_index + 1 < lines.count {
                    current_line = lines[current_index + 1]
                    if current_line.type == .block_end {
                        break
                    }
                    if current_line.type == .line {
                        block_body.append("\(current_line.body)\n")
                    }

                    current_index += 1
                }
                block_linenum_end = current_index

                if block_type == .doc, docHasAppeared == false {
                    result.append(ExMarkBlock(
                        linenum_start: block_linenum_start, linenum_end: block_linenum_end,
                        body: block_body,
                        type: block_type,
                        style: block_style
                    ))
                    docHasAppeared = true
                } else if block_type != .doc {
                    result.append(ExMarkBlock(
                        linenum_start: block_linenum_start, linenum_end: block_linenum_end,
                        body: block_body,
                        type: block_type,
                        style: block_style
                    ))
                }
            case .block_end:
                break
            default:
                fatalError()
            }
        }
        current_index += 1
    }

    return result
}
