cask "tetherbug" do
  version "0.1.1"
  sha256 "8271c2c98431e5e789a5c3f7b16c0a37dc5c6203cb970ea1849af6fd05391c61"

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
