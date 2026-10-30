class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.14/browser-session-v0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "294a3339c8f015fab3ab45b718a269604294e453e3224ca7046544fc825fba3f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.14/browser-session-v0.1.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "af8f04461120208a292f1cb0b43d8af9d2ee6c41449614aa8e8c61e5e2112ea9"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.14/browser-session-v0.1.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "987680419d4cde52c3a5ca4305dd9790250e580be66bb7ed9010bf134b37afd6"
    end
  end

  def install
    libexec.install "browser-session", "webroot"
    # The takeover role serves the UI from TAKEOVER_WEBROOT; default it to the bundled one.
    (bin/"browser-session").write_env_script libexec/"browser-session",
      TAKEOVER_WEBROOT: "${TAKEOVER_WEBROOT:-#{libexec}/webroot}"
    pkgshare.install "systemd"
  end

  test do
    assert_match "STATE_DIR is required", shell_output("#{bin}/browser-session mcp 2>&1", 1)
  end
end
