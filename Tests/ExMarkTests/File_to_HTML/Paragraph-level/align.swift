@testable import ExMark
import XCLog
import XCTest

class Test_Block_ParagraphAlign: XCTestCase {
    func test_common() {
        let file = """
        [[paragraph
        l
        ]]
        """
        let ans = """
        <p>l<br></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_left() {
        let file = """
        [[paragraph, left
        l
        ]]
        """
        let ans = """
        <p>l<br></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_center() {
        let file = """
        [[paragraph, center
        c
        ]]
        """
        let ans = """
        <center>c<br></center>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_right() {
        let file = """
        [[paragraph, right
        r
        ]]
        """
        let ans = """
        <p align="right">r<br></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
}
