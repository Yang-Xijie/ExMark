@testable import ExMark
import XCLog
import XCTest

class Test_Block_Quote: XCTestCase {
    func test_common() {
        let file = """
        [[quote
        1
        ]]
        """
        let ans = """
        <blockquote>1</blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_double() {
        let file = """
        [[quote
            2
        ]]
        """
        let ans = """
        <blockquote><blockquote>2</blockquote></blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_triple() {
        let file = """
        [[quote
                3
        ]]
        """
        let ans = """
        <blockquote><blockquote><blockquote>3</blockquote></blockquote></blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_flat() {
        let file = """
        [[quote
            2
            2
        ]]
        """
        let ans = """
        <blockquote><blockquote>2<br>2</blockquote></blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    

    func test_down() {
        let file = """
        [[quote
                3
            2
        1
        ]]
        """
        let ans = """
        <blockquote><blockquote><blockquote>3</blockquote>2</blockquote>1</blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_down_fast() {
        let file = """
        [[quote
                3
        1
        ]]
        """
        let ans = """
        <blockquote><blockquote><blockquote>3</blockquote></blockquote>1</blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_up() {
        let file = """
        [[quote
        1
            2
                3
        ]]
        """
        let ans = """
        <blockquote>1<blockquote>2<blockquote>3</blockquote></blockquote></blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    func test_up_fast() {
        let file = """
        [[quote
        1
                3
        ]]
        """
        let ans = """
        <blockquote>1<blockquote><blockquote>3</blockquote></blockquote></blockquote>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

}
