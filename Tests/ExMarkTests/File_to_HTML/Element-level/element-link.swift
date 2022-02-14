@testable import ExMark
import XCLog
import XCTest

class Test_element_link: XCTestCase {
    func test_common() {
        let file = """
        [Yang Xijie](link https://github.com/Yang-Xijie)
        """
        let ans = """
        <p><a href="https://github.com/Yang-Xijie">Yang Xijie</a></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
}
