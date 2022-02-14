@testable import ExMark
import XCLog
import XCTest

class ExMarkTests: XCTestCase {
    func test_block_code(){
        let file = """
        [[code swift
        let str = "Hello, world!"
        print(str)
        ]]
        """
        let html = Render_Document_to_HTML(Parse_Lines_to_Document(Parse_File_to_Lines(file)))
        XCLog(.trace, html)
    }
}
