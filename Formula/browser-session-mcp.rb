class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.1/browser-session-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "caf724758a26778d20800032fdfbfb5f514a87a40eb6148d4a5941425f8847b4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.1/browser-session-v0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0c5b9c6dfb855edc4adc1a045d0201cabe8b2f5608bc9ec709c0302a61dc5ffb"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.1/browser-session-v0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ed69657a3074f8d7029b0aa238a1e8168b876f54c965482421cea634a8ce751b"
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
