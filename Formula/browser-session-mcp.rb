class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.23/browser-session-v0.1.23-aarch64-apple-darwin.tar.gz"
      sha256 "a943bf1188ee058676fd4819981c677ef6b6e4661bc521f0cd918db8d206af47"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.23/browser-session-v0.1.23-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a7c537c6635fc867781aa844e4b37a0c9175d8bb00463cebc788beec76bfbd92"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.23/browser-session-v0.1.23-aarch64-unknown-linux-musl.tar.gz"
      sha256 "57f51112deda3851eae6f90aa352a153bc6dc975fc67c3112242f05ccb8157a2"
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
