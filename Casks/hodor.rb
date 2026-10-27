cask "hodor" do
  arch arm: "arm64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "6d843e83e39b1fb8b9a6feafed21f3fbf8ec05fe88057776efc5a435b7e946fc",
         intel: "cc5dbb42c602471a7fa1248af9cb116ae263bd42beb2aecf8dcaab504e040e22"

  url "https://github.com/davidemaggi/Hodor/releases/download/v#{version}/Hodor-#{version}-mac-#{arch}.zip"
  name "Hodor"
  desc "Save Kubernetes port-forwards as templates and run them on any cluster"
  homepage "https://github.com/davidemaggi/Hodor"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Hodor.app"
  binary "#{appdir}/Hodor.app/Contents/Resources/bin/hodor"

  # Not notarized by Apple yet: without this, macOS refuses to open it the first time
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Hodor.app"]
  end

  zap trash: [
    "~/.hodor",
    "~/Library/Application Support/Hodor",
    "~/Library/Logs/Hodor",
    "~/Library/Preferences/dev.davidemaggi.hodor.plist",
    "~/Library/Saved Application State/dev.davidemaggi.hodor.savedState",
  ]
end
