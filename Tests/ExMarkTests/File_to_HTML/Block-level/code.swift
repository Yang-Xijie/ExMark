@testable import ExMark
import XCLog
import XCTest

class Test_Block_Code: XCTestCase {
    func test_languageSwift() {
        let file = """
        [[code swift
        let str = "Hello, world!"
        print(str)
        ]]
        """
        let ans = """
        <pre><code class="language-swift">let str = &quot;Hello, world!&quot;<br>print(str)<br></code></pre>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_languageShell() {
        let file = """
        [[code sh -n
        echo "Hello, world!"
        cat hello.txt
        ]]
        """
        let ans = """
        <pre><code class="language-sh">echo &quot;Hello, world!&quot;<br>cat hello.txt<br></code></pre>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }
    
    // TODO: func test_languageHTML()

    func test_noLanguage() {
        let file = """
        [[code
        content
        ]]
        """
        let ans = """
        <pre><code>content<br></code></pre>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    func test_noCode() {
        let file = """
        [[
        content
        ]]
        """
        let ans = """
        <pre><code>content<br></code></pre>
        """

        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCTAssertEqual(html, ans)
    }

    // TODO: -n parameter
}
