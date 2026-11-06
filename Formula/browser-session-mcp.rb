class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.18/browser-session-v0.1.18-aarch64-apple-darwin.tar.gz"
      sha256 "a14245722f5f03f7f77b7e12d171a9c9e2fb13a090b17b6a66a779c66521d10a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.18/browser-session-v0.1.18-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c583ef98da5c2846ce0384ae4111ba95bfc3e14e6b3d858368bb3b33cc7aa0c0"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.18/browser-session-v0.1.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8261c627ea14bce0dbcf09c6ce067ebd4a35523363c09aa42c83b2701c8fdd0f"
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
