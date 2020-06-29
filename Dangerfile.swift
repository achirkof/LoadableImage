// Dangerfile.swift

import Danger

let danger = Danger()

// Make it more obvious that a PR is a work in progress and shouldn't be merged yet
if danger.github.pullRequest.title.contains("[WIP]") {
    warn("PR is classed as Work in Progress")
}

// Warn when library files has been updated but not tests.
let hasAppChanges = !danger.git.modifiedFiles.filter({file in
    return file.contains("Sources")
}).isEmpty
let testsUpdated = !danger.git.modifiedFiles.filter({file in
    return file.contains("Tests")
}).isEmpty
if hasAppChanges && !testsUpdated {
    warn("The library files were changed, but the tests remained unmodified.")
}

SwiftLint.lint(inline: true, configFile: ".github/workflows/swiftlint.yml", lintAllFiles: true)
