//
//  Trie.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-18.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

extension String {
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}
extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

class Trie<V> {
    
    private class Node {
        var val: V? = nil
        var children = [Node?](repeating: nil, count: 256)
    }
    
    private var root: Node? = nil
    private var n: Int = 0
    private var R: Int = 256
    
    init() {}
    
    func contains(key: String) -> Bool {
        return get(key: key) != nil
    }
    
    func get(key: String) -> V? {
        let x: Node? = get(x: root, key: key, d: 0)
        
        if x == nil {
            return nil
        }
        
        return x?.val
    }
    
    private func get(x: Node?, key: String, d: Int) -> Node? {
        if x == nil {
            return nil
        }
        
        if d == key.count {
            return x
        }
        
        let index = key.index(key.startIndex, offsetBy: d)
        let c  = key[index]
        return get(x: x?.children[Int(c.asciiValue!)], key: key, d: d+1)
    }
    
    func put(key: String, val: V?) {
        if val == nil {
            delete(key: key)
        } else {
            root = put(x: root, key: key, val: val, d: 0)
        }
    }
    
    private func put(x: Node?, key: String, val: V?, d: Int) -> Node? {
        var copyX = x
        
        if copyX == nil {
            copyX = Node()
        }
        
        if d == key.count {
            if copyX?.val == nil {
                n += 1
            }
            
            copyX?.val = val
            return copyX
        }
        
        let index = key.index(key.startIndex, offsetBy: d)
        let c  = key[index]
        copyX?.children[Int(c.asciiValue!)] = put(x: copyX?.children[Int(c.asciiValue!)], key: key, val: val, d: d+1)
        return copyX
    }
    
    func size() -> Int {
        return n
    }
    
    func isEmpty() -> Bool {
        return n == 0
    }
    
    func getKeysWithPrefix(prefix: String) -> [String] {
        var results = [String]()
        let x = get(x: root, key: prefix, d: 0)
        collect(x: x, prefix: prefix, results: &results)
        return results
    }
    
    private func collect(x: Node?, prefix: String, results: inout [String]) {
        var copyPrefix = prefix
        
        if x == nil {
            return
        }
        
        if x?.val != nil {
            results.append(copyPrefix)
        }
        
        for c in 0..<R {
            copyPrefix += "\(UnicodeScalar(c)!)"
            collect(x: x?.children[c], prefix: copyPrefix, results: &results)
            copyPrefix = String(copyPrefix.dropLast())
        }
    }

    func delete(key: String) {
        root = delete(x: root, key: key, d: 0)
    }
    
    private func delete(x: Node?, key: String, d: Int) -> Node? {
        if x == nil {
            return nil
        }
        
        if d == key.count {
            if x?.val != nil {
                n -= 1
            }
            x?.val = nil
        } else {
            let index = key.index(key.startIndex, offsetBy: d)
            let c  = key[index]
            x?.children[Int(c.asciiValue!)] = delete(x: x?.children[Int(c.asciiValue!)], key: key, d: d+1)
        }
        
        if x?.val != nil {
            return x
        }
        
        for c in 0..<R {
            if x?.children[c] != nil {
                return x
            }
        }
        
        return nil
    }
}
