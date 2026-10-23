class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.4/browser-session-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "dc3429e7091dc75ad792747b92299b7bde729b6af0c35795e25d6f189ea3618f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.4/browser-session-v0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c73c5da734802aa190bdb8e3029e2b8561c1dbc2ddf3f4fde4ee188128f06126"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.4/browser-session-v0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "edc5df8e6ea510907ad297e9d101536c4c749f8d87074763c7a1f2c40a21b09e"
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
