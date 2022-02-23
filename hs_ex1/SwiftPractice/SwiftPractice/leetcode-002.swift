//
//  leetcode-002.swift
//  SwiftPractice
//
//  Created by 유한석 on 2022/02/23.
//

import Foundation
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() {
        self.val = 0
        self.next = nil
    }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var val1, val2 : Int
    var resultNode = ListNode()
    
}




