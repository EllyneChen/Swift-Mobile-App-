import Foundation

class DataLoader {
    static func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Could not find \(filename) in main bundle.")
        }
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Could not parse \(filename) as \(T.self): \(error)")
        }
    }
}
