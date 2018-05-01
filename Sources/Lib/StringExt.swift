extension String {
    typealias SimpleToFromRepalceList = [(fromSubString:String,toSubString:String)]

    // See http://stackoverflow.com/questions/24200888/any-way-to-replace-characters-on-swift-string
    //
    func simpleReplace(_ mapList:SimpleToFromRepalceList ) -> String
    {
        var string = self

        for (fromStr, toStr) in mapList {
            let separatedList = string.components(separatedBy: fromStr)
            if separatedList.count > 1 {
              string = separatedList.joined(separator: toStr)
            }
        }

        return string
    }

    func xmlSimpleUnescape() -> String
    {
        let mapList : SimpleToFromRepalceList = [
            ("&amp;",  "&"),
            ("&quot;", "\""),
            ("&#x27;", "'"),
            ("&#39;",  "'"),
            ("&#x92;", "'"),
            ("&#x96;", "-"),
            ("&gt;",   ">"),
            ("&lt;",   "<")]

        return self.simpleReplace(mapList)
    }

    var xmlEscape: String {
        let mapList : SimpleToFromRepalceList = [
            ("&",  "&amp;"),
            ("\"", "&quot;"),
            ("'",  "&#x27;"),
            (">",  "&gt;"),
            ("<",  "&lt;")]

        return self.simpleReplace(mapList)
    }
}
