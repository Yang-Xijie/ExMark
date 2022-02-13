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
        let html = ParseBlocksToHTML(ParseLinesToBlocks(ParseFileToLines(file)))
        XCLog(.trace, html)
    }
}
