class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.6/browser-session-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "aa33507ce637572e5dae401eeae3b1440683e35411ff16bdb2fd97cc0a961ae5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.6/browser-session-v0.1.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1140124ea55b3558873a1951d4914cf19b82bff9b589a56bdf5729ebd32dec35"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.6/browser-session-v0.1.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "529adc6d95750f73e128a424a4ed0781c726f701fb3096e8b0bbff3514582724"
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
