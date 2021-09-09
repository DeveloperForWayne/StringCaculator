//
//  StringCaculator.swift
//  StringCaculator
//
//  Created by Wei Xu on 2021-09-08.
//

import Foundation

class StringCaculator {
    func Add(numbers: String) throws -> Int {
        var value = 0
        if numbers.isEmpty {
            return value
        }
        
        // Has delimiter
        if numbers.hasPrefix("//") {
            
            let startIndex = numbers.range(of: "\n", options: .literal)!.lowerBound
            var numWithoutDelimiter = numbers[startIndex...].dropFirst(1)
            
            let arrWithDelimiter = numbers.split{$0 == "\n"}
            var delimiterStr = arrWithDelimiter[0].dropFirst(2)
            
            var replacednum = numWithoutDelimiter
            if delimiterStr.contains(",") {
                let delimiterArr = delimiterStr.split{$0 == ","}
                for delim in delimiterArr {
                    replacednum = Substring(replacednum.replacingOccurrences(of: delim, with: ","))
                }
            }

            do {
                if replacednum.isEmpty {
                    value = try sum(numbers: String(numWithoutDelimiter), delimiter: String(delimiterStr))
                } else {
                    value = try sum(numbers: String(replacednum), delimiter: ",")
                }
            } catch MyError.negativeError(let errorMessage) {
                print(errorMessage)
                throw MyError.negativeError(errorMessage)
            } catch {
                print("Error")
            }
        } else {
            do {
                value = try sum(numbers: numbers, delimiter: ",")
            } catch MyError.negativeError(let errorMessage) {
                print(errorMessage)
                throw MyError.negativeError(errorMessage)
            } catch {
                print("Error")
            }
        }

        return value
    }
    
    func sum(numbers: String, delimiter: String) throws -> Int {
        var val=0
        let numbersArr = numbers.components(separatedBy: delimiter)
        for number in numbersArr {
            let numStr = number.trimmingCharacters(in: .whitespacesAndNewlines)
            let numInt = Int(numStr) ?? 0
            guard numInt >= 0 else {
                throw MyError.negativeError("Negatives not allowed: \(numInt) is negative")
            }
            
            if numInt<=1000 {
                val += numInt
            }

        }
        return val
    }
}

enum MyError: Error, Equatable {
    case negativeError(String)
}
