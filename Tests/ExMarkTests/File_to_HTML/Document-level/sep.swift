@testable import ExMark
import XCLog
import XCTest

class Test_Block_sep: XCTestCase {
    func test_9() {
        let file = """
        ---sep---
        """
        let ans = """
        <hr>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_3() {
        let file = """
        ---
        """
        let ans = """
        <hr>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
}
