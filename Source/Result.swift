/**

 The MIT License (MIT)

 Copyright (c) 2015 Angel Casado

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import Foundation

public enum Result<T>: ResultType {
    case Success(T)
    case Failure(ErrorType)

    public init(value: T) {
        self = .Success(value)
    }

    public init(error: ErrorType) {
        self = .Failure(error)
    }

    public var value: T? {
        get {
            switch self {
            case let .Success(value): return value
            case .Failure: return nil
            }
        }
    }

    public var error: ErrorType? {
        get {
            switch self {
            case .Success: return nil
            case let .Failure(error): return error
            }
        }
    }
}

public extension Result {
    public func map<U>(@noescape f: T -> U) -> Result<U> {
        switch self {
        case let .Success(value): return .Success(f(value))
        case let .Failure(error): return .Failure(error)
        }
    }

    public func flatMap<U>(@noescape f: T -> Result<U>) -> Result<U> {
        switch self {
        case let .Success(value): return f(value)
        case let .Failure(error): return .Failure(error)
        }
    }
}
