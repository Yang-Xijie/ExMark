import Foundation

var testfile: String = TestFile.full

enum TestFile {
    static var full: String {
        var s = ""
//        _ = [title, toc, sep, doc, code, math, list, quote, table, paragraph, paragraph_align].map {
//        _ = [toc, doc, code, math, list, quote, table, paragraph].map {
        _ = [paragraph].map {
            s.append(contentsOf: $0.appending("\n"))
        }
        return s
    }

    // MARK: -

    static let title = """
    # t1
    ## t2
    ### t3
    #### t4
    ##### t5
    ###### t6
    """

    static let toc = """
    ---toc---
    """

    static let sep = """
    ---
    ---sep---
    """

    static let doc = """
    [[doc
    author: [Yang-Xijie](link https://github.com/Yang-Xijie)
    tags: exmark, tutorials
    language: [en], [zh]
    ]]
    """

    static let code = """
    [[
    codecodecode
    ]]

    [[code
    codecodecode
    ]]

    [[code swift -n
    if hello {
        print("Hello, world!")
    }
    ]]

    [[code sh -n
    echo "Hello, world!"
    cat hello.txt
    ]]
    """

    static let math = """
    [[math
    y = x^2
    \\latex
    ]]
    """
    static let list = """
    [[list
    1 x
    2 xx
    3 xxx
        3.1 x
        3.2 xx
        3.3 xxx
    4 xxx
    ]]
    """

    static let quote = """
    [[quote
            2
            2
    ]]

    [[quote
        hello!
    hi!
    ]]

    [[quote
            3
            3
        2
        2
    1
        2
    1
    1
        2
    ]]
    """

    static let table = """
    [[table
    Monday|Tuesday|Wednesday
    ||
    A|B|C
    1|2|3
    ]]
    """

    static let paragraph = """
    [c](code)
    [b](bold) [i](italic) [ib](italic, bold)
    [d](delete) [u](under)
    """
    
    static let paragraph_embed = """
    [[ib](italic)](bold)
    """

    static let paragraph_align = """
    [[paragraph
    left_nil
    ]]
    [[paragraph left
    left
    ]]
    [[paragraph center
    center
    ]]
    [[paragraph right
    right
    ]]
    """

    static let image = """
    [mizore](image /usr/picture/mizore.png)
    [mizore](image /usr/picture/mizore.png, size 5)
    """
}
