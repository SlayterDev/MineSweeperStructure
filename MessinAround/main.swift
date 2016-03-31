//
//  main.swift
//  MessinAround
//
//  Created by Bradley Slayter on 3/29/16.
//  Copyright © 2016 Slayter Development. All rights reserved.
//

import Foundation
import GameplayKit

let gridWidth = 9
let gridHeight = gridWidth
let numberOfMines = 10
var grid = [[String]](count: gridWidth, repeatedValue: [String](count: gridHeight, repeatedValue: " "))

let randomGen = GKMersenneTwisterRandomSource()
let distribution = GKShuffledDistribution(randomSource: randomGen, lowestValue: 0, highestValue: gridHeight-1)

func inBounds(x: Int, y: Int) -> Bool {
    if (x < 0 || x > gridWidth - 1) {
        return false
    } else if (y < 0 || y > gridHeight - 1) {
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
    var i = 0
    while i < numMines {
        let x = distribution.nextIntWithUpperBound(gridWidth-1)
        let y = distribution.nextInt()
        if grid[x][y] != "*" {
            grid[x][y] = "*"
            i += 1
        }
    }
    
    for x in 0..<gridWidth {
        for y in 0..<gridHeight {
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
    let dashes = [String](count: gridHeight * 2 + 3, repeatedValue: "-").reduce("", combine: +)
    
    print(dashes)
    
    for line in grid {
        let printableLine = line.reduce("| ") { $0 + "\($1) " } + "|"
        print(printableLine)
    }
    
    print(dashes)
}

fillGrid(numberOfMines)
printGrid()

