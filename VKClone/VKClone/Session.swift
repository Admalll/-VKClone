import Foundation

final class Session {
    static let instance = Session()
    private init(){}
    var token = ""
    var userID: Int = 0
}
