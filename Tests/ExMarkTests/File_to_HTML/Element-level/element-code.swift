@testable import ExMark
import XCLog
import XCTest

class Test_element_code: XCTestCase {
    func test_common() {
        let file = """
        [c](code)
        """
        let ans = """
        <p><code>c</code></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_no() {
        let file = """
        [c]
        """
        let ans = """
        <p><code>c</code></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
}
