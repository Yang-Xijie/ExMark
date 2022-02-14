import Foundation

func Parse_File_to_Lines(_ file: String) -> EMLines {
    var result: EMLines = []

    let lines: [String] = file
        .trimmingCharacters(in: CharacterSet.whitespaces) // delete \n at the end of lines
        .replacingOccurrences(of: "\t", with: "    ") // no \t
        .components(separatedBy: CharacterSet.newlines)

    let lines_array_trimmed: [String] = lines.map {
        $0.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    var linenum = 0

    for line in lines_array_trimmed {
        if line.count != 0 {
            if line.first! == "#" {
                if String(line.prefix(2)) == "# " {
                    result.append(
                        EMLine(linenum: linenum,
                                   type: .title1,
                                   body: String(line.suffix(line.count - 2))))
                } else if String(line.prefix(3)) == "## " {
                    result.append(
                        EMLine(linenum: linenum,
                                   type: .title2,
                                   body: String(line.suffix(line.count - 3))))
                } else if String(line.prefix(4)) == "### " {
                    result.append(
                        EMLine(linenum: linenum,
                                   type: .title3,
                                   body: String(line.suffix(line.count - 4))))
                } else if String(line.prefix(5)) == "#### " {
                    result.append(
                        EMLine(linenum: linenum,
                                   type: .title4,
                                   body: String(line.suffix(line.count - 5))))
                } else if String(line.prefix(6)) == "##### " {
                    result.append(
                        EMLine(linenum: linenum,
                                   type: .title5,
                                   body: String(line.suffix(line.count - 6))))
                } else if String(line.prefix(7)) == "###### " {
                    result.append(
                        EMLine(linenum: linenum,
                                   type: .title6,
                                   body: String(line.suffix(line.count - 7))))
                } else { // start with `#` but no space after it
                    result.append(EMLine(linenum: linenum,
                                             type: .line,
                                             body: lines[linenum]))
                }
            } else if line == "---toc---" {
                result.append(EMLine(linenum: linenum,
                                         type: .toc,
                                         body: ""))
            } else if line == "---sep---" || line == "---" {
                result.append(EMLine(linenum: linenum,
                                         type: .sep,
                                         body: ""))
            } else if
                line == "[[" // block-level code
                || (String(line.prefix(2)) == "[[" && !line.contains("]]")) {
                result.append(EMLine(linenum: linenum,
                                         type: .block_start,
                                         body: String(line.suffix(line.count - 2))))
            } else if line == "]]" {
                result.append(EMLine(linenum: linenum,
                                         type: .block_end,
                                         body: ""))

            } else { // not start with `# ` `---` `[[` `]]`, not a block => a line
                result.append(EMLine(linenum: linenum,
                                         type: .line,
                                         body: lines[linenum]))
            }
        } else { // `line.count == 0` => ""
            result.append(EMLine(linenum: linenum,
                                     type: .enter,
                                     body: ""))
        }
        linenum += 1
    }

    return result
}
