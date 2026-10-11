cask "tetherbug" do
  version "0.1.0"
  sha256 "0fa9c5c5b12c80dd01e2f78b52a57dc1492480cbea6a11b01dc5458cc786bee7"

  url "https://github.com/xav-ie/Tetherbug/releases/download/v#{version}/Tetherbug-v#{version}.zip"
  name "Tetherbug"
  desc "Turns your Android phone's hotspot on when your Mac loses Wi-Fi"
  homepage "https://github.com/xav-ie/Tetherbug"

  depends_on macos: ">= :sonoma"

  app "Tetherbug.app"
  binary "#{appdir}/Tetherbug.app/Contents/MacOS/Tetherbug", target: "tetherbug"

  zap trash: [
    "~/Library/Application Support/Tetherbug",
    "~/Library/Preferences/ie.xav.tetherbug.settings.plist",
  ]

  caveats <<~TEXT
    Tetherbug isn't notarized, so macOS blocks it the first time you open it. Allow it under
    System Settings → Privacy & Security → Open Anyway.
  TEXT
end
