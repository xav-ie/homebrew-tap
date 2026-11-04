class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.16/browser-session-v0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "5c75ec7cc00fd91f9cea5709069a1b42640395cec6612cfa01f80bc566b335d4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.16/browser-session-v0.1.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "debb0807c626fa6718b98587abca622e060a1c0fd46f4a169a73fc04ac47d125"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.16/browser-session-v0.1.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e21a5c5ba2569878fe68ece99b1f416ffcc2bbb899c62c3791ed8455e62bc29a"
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
