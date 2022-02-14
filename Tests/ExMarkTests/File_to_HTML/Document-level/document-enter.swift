@testable import ExMark
import XCLog
import XCTest

class Test_document_enter: XCTestCase {
    func test_1() {
        let file = """

        """
        let ans = """
        <br>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_2() {
        let file = """


        """
        let ans = """
        <br><br>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
}
