class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.8/browser-session-v0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "87dd0ad3a73840e66a8d89083597b2a37c047ee7152783bf1381136feba9fc6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.8/browser-session-v0.1.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eae276ae1515ae37a9098c83f4f479210c8c36ed8b5dd23ba63197f01447dd80"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.8/browser-session-v0.1.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0953cddb828503ac9d62c8e0cc8593c77188e477cc9553399cf8a0b5d71a7f51"
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
