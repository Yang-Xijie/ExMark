@testable import ExMark
import XCLog
import XCTest

class ParagraphToHTML: XCTestCase {
    func test_enter() {
        // TODO: enter 怎么渲染的这么麻烦 直接<br>不行吗
        let file = """

        """
        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        let ans = """
        <br>
        """

        XCTAssertEqual(html.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                       ans.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }

    func test_bold() {
        let file = """
        [b](bold)
        """
        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        let ans = """
        <p align="left"><strong>b</strong></p>
        """

        XCTAssertEqual(html.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                       ans.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }
}
