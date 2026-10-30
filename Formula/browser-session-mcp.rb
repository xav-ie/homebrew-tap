class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.13/browser-session-v0.1.13-aarch64-apple-darwin.tar.gz"
      sha256 "b1ddddcb6b178443474f3f823b98b7c952e35ee403274948fd265ef490ad8251"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.13/browser-session-v0.1.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "711aa1c148aae446a83726e0cee7ac14d8d5d194898aec1bb493e3387c9d3a48"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.13/browser-session-v0.1.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "59714a333e5b7fa6c2084b241050f5925f577a7604b44d81f143761e46711a66"
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
