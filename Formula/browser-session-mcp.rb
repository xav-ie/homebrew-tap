class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.2/browser-session-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "5c025b1ddc9fee3f84f1e314ab3a92153b424082bd577c67f2463b0fe4281b82"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.2/browser-session-v0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "247a0b5d5703916c0d7447727f2ea9cff65a8be8cbf077dd62c3a01db135a842"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.2/browser-session-v0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c090f7264d1a7d1fbc32907205c4e4f3d306a9fc4f209fdfdb71d53965a719ec"
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
