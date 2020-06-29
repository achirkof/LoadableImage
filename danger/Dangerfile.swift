// Dangerfile.swift

import Danger
import DangerSwiftLint // package: https://github.com/ashfurrow/danger-swiftlint.git

let danger = Danger()

// Make it more obvious that a PR is a work in progress and shouldn't be merged yet
if danger.github.pullRequest.title.contains("[WIP]") {
    warn("PR is classed as Work in Progress")
}

// Warn when library files has been updated but not tests.
let has_app_changes = !danger.git.modifiedFiles.filter({file in
    return file.contains("Sources")
}).isEmpty
let tests_updated = !danger.git.modifiedFiles.filter({file in
    return file.contains("Tests")
}).isEmpty
if has_app_changes && !tests_updated {
    warn("The library files were changed, but the tests remained unmodified. Consider updating or adding to the tests to match the library changes.")
}

SwiftLint.lint(directory: "Sources", configFile: ".github/workflows/swiftlint.yml")
