# Parse Flow

## Generate EMDocument

`ExFile`(`.exmark`, `String`) -> EMLines(`[EMLine]`, `[String]`) -> (several `EMLines` to one `EMBlock`) -> EMDocument(`[EMBlocks]`)

If `EMBlock` is a paragraph:
`EMBlock.body`(`String`) -> `EMParagraph` ->   

## Generate HTML

EMDocument(`[EMBlocks]`) -> HTML(`String`)
