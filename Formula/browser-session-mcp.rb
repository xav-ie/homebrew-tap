class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.20/browser-session-v0.1.20-aarch64-apple-darwin.tar.gz"
      sha256 "d225223201c450b4275d57335bca1ee84ee8b848f0d55722ce548a30cf489da9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.20/browser-session-v0.1.20-x86_64-unknown-linux-musl.tar.gz"
      sha256 "16cad7dae2df4a0579f95edef4989a092e0fe7ac082b386cb6d2e972cbd41559"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.20/browser-session-v0.1.20-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0ebb38d6be0e5a70d16dd9d81397eb74d2d2ad2a09b81a7706385e8f358deb78"
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
