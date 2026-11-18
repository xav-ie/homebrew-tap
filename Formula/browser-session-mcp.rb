class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.24/browser-session-v0.1.24-aarch64-apple-darwin.tar.gz"
      sha256 "bbd37b30011a83be4fbbc039ef5101bb695fab0a7898bc407db0b5e38c7c53a9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.24/browser-session-v0.1.24-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b6b4711e3f03a6fd1077839ae6ce9f7804d46cf09227592884c62a93b9d46324"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.24/browser-session-v0.1.24-aarch64-unknown-linux-musl.tar.gz"
      sha256 "476f466a2f68745b7776656e862f8727fc0819e22529c19644aa729975526fb9"
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
