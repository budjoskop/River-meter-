//
//  MicroDOM.swift
//  River Meter
//
//  Created by Ognjen Tomic on 31.12.20..
//

import Foundation


class MicroDOM: NSObject, XMLParserDelegate {
    private let parser: XMLParser
    private var stack = [XMLNode]()
    private var tree: XMLNode?

    init(data: Data) {
        parser = XMLParser(data: data)
        super.init()
        parser.delegate = self
    }

    func parse() -> XMLNode? {
        parser.parse()

        guard parser.parserError == nil else {
            return nil
        }

        return tree
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        let node = XMLNode(tag: elementName, data: "", attributes: attributeDict, childNodes: [])
        stack.append(node)
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let lastElement = stack.removeLast()

        if let last = stack.last {
            last.childNodes += [lastElement]
        } else {
            tree = lastElement
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        stack.last?.data = string
    }
}
