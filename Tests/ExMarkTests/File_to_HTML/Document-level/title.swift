@testable import ExMark
import XCLog
import XCTest

class Test_Block_title: XCTestCase {
    func test_1() {
        let file = """
        # t1
        """
        let ans = """
        <h1>t1</h1>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_2() {
        let file = """
        ## t2
        """
        let ans = """
        <h2>t2</h2>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_3() {
        let file = """
        ### t3
        """
        let ans = """
        <h3>t3</h3>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_4() {
        let file = """
        #### t4
        """
        let ans = """
        <h4>t4</h4>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_5() {
        let file = """
        ##### t5
        """
        let ans = """
        <h5>t5</h5>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_6() {
        let file = """
        ###### t6
        """
        let ans = """
        <h6>t6</h6>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
}
