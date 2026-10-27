cask "queuecumber" do
  version "1.0.5"
  sha256 "fb9df3f6fbf67252593e5a5e87d4934db96bbd39b1086beb88de9c666597247c"

  url "https://github.com/davidemaggi/QueueCumber/releases/download/v#{version}/QueueCumber-#{version}-mac-arm64-unsigned.zip"
  name "QueueCumber"
  desc "Inspect RabbitMQ and Kafka traffic without touching application queues"
  homepage "https://github.com/davidemaggi/QueueCumber"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "QueueCumber.app"

  # Not notarized by Apple: without this, macOS refuses to open it the first time
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/QueueCumber.app"]
  end

  zap trash: [
    "~/Library/Application Support/QueueCumber",
    "~/Library/Preferences/dev.queuecumber.desktop.plist",
    "~/Library/Saved Application State/dev.queuecumber.desktop.savedState",
  ]
end
