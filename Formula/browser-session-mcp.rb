class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.12/browser-session-v0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "0b10a273e6b39ee7eba049c9bbf74e0f7a1b1a058d88ec731a13dfca67a9400d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.12/browser-session-v0.1.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f7fdaa80d5a0e2ea12fc7f5816bf790caebf863934ccd568413756dafa824918"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.12/browser-session-v0.1.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "260fde5563311c2112ee6145851f85f5e0fb7c49d0a96af7cf1d0bdae2c915a8"
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
