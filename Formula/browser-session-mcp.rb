class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.9/browser-session-v0.1.9-aarch64-apple-darwin.tar.gz"
      sha256 "7e28549774e42258b610801288e95c46f2adc65eab242bb0ede11532b49c1e56"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.9/browser-session-v0.1.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b9c9a39fe54ee58fbbf032148d7429c71bab5fe946bee8c17056d0fa3d1a1924"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.9/browser-session-v0.1.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1e548a39b6ab35be4b18a04e2dfab0c342562bb7f42f8f08cfd03f08d734c8cd"
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
