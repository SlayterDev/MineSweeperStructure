//
//  main.swift
//  MessinAround
//
//  Created by Bradley Slayter on 3/29/16.
//  Copyright © 2016 Slayter Development. All rights reserved.
//

import Foundation

let gridWidth = 10
var grid = [[String]](count: gridWidth, repeatedValue: [String](count: gridWidth, repeatedValue: " "))

func inBounds(x: Int, y: Int) -> Bool {
    if (x < 0 || x > gridWidth - 1) {
        return false
    } else if (y < 0 || y > gridWidth - 1) {
        return false
    } else {
        return true
    }
}

func getNeighborMineCount(x: Int, y: Int) -> Int {
    var count = 0
    
    for i in -1...1 {
        for j in -1...1 {
            if inBounds(x + i, y: y + j) && grid[x + i][y + j] == "*" {
                count += 1
            }
        }
    }
    
    return count
}

func fillGrid(numMines: Int) {
    for var i in 0..<numMines {
        let x = Int(arc4random_uniform(UInt32(gridWidth)))
        let y = Int(arc4random_uniform(UInt32(gridWidth)))
        if grid[x][y] != "*" {
            grid[x][y] = "*"
        } else {
            i -= 1
        }
    }
    
    for x in 0..<gridWidth {
        for y in 0..<gridWidth {
            if grid[x][y] == "*" {
                continue
            }
            
            let cnt = getNeighborMineCount(x, y: y)
            if cnt > 0 {
                grid[x][y] = "\(cnt)"
            }
        }
    }
}

func printGrid() {
    print("-----------------------")
    
    for line in grid {
        let printableLine = line.reduce("| ") { $0 + "\($1) " } + "|"
        print(printableLine)
    }
    
    print("-----------------------")
}

fillGrid(10)
printGrid()

