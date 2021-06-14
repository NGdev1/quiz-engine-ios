var resourcesBundle: Bundle {
    guard
        let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent("MapResources.bundle"),
        let resourcesBundle = Bundle(url: bundleUrl)
    else {
        fatalError("Base URL should at start time of app")
    }
    return resourcesBundle
}
