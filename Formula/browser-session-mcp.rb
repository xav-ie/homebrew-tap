class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.3/browser-session-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "4200d093666f76665973873ae3b5ef4a0611859ef824078020b9bca2d7334048"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.3/browser-session-v0.1.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "20b54be4fe8a474de721fcd74cdd25e03cfa0eb06879b7a797c5c59e58a1a48b"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.3/browser-session-v0.1.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b947e0353aaa68036180cdc7b1d13cc2dd982a791801b53e0ca23f609fec63a6"
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
