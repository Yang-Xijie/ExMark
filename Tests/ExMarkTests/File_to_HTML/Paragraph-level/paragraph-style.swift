@testable import ExMark
import XCLog
import XCTest

class Test_paragraph_style: XCTestCase {
    func test_bold() {
        let file = """
        [b](bold)
        """
        let ans = """
        <p><strong>b</strong></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_italic() {
        let file = """
        [i](italic)
        """
        let ans = """
        <p><em>i</em></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_italicBold() {
        let file = """
        [ib](italic, bold)
        """
        let ans = """
        <p><em><strong>ib</strong></em></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_delete() {
        let file = """
        [d](delete)
        """
        let ans = """
        <p><del>d</del></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_under() {
        let file = """
        [u](under)
        """
        let ans = """
        <p><u>u</u></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    // TODO: line code
    
    func test_code() {
        let file = """
        [c](code)
        """
        let ans = """
        <p><code>c</code></p>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    // TODO: line math
    
    // TODO:
//    func test_italicBoldEmbedded() {
//        let file = """
//        [b[ib](italic)b](bold)
//        """
//        let ans = """
//        <p><strong>b<em>ib</em>b</strong></p>
//        """
//
//        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
//        XCTAssertEqual(html, ans)
//    }

    // TODO:
//    func test_boldItalicEmbedded() {
//        let file = """
//        [i[bi](bold)i](italic)
//        """
//        let ans = """
//        <p><em>i<strong>bi</strong>i</em></p>
//        """
//
//        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
//        XCTAssertEqual(html, ans)
//    }
}
