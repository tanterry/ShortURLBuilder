# Short URL Builder
This app shortens long URLs using multiple providers.

# Configuration
Create a `Config.swift` file under `ShortURLBuilderProvider/Sources/ShortURLBuilderProvider` to define the required token/API key.

```swift
enum Config {
    static let bitlyToken = "YOUR_TOKEN"

    static let cuttlyApiKey = "YOUR_API_KEY"
}
```
