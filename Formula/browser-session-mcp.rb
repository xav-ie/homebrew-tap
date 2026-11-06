class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.19/browser-session-v0.1.19-aarch64-apple-darwin.tar.gz"
      sha256 "39ec3a41eb5572aee1f2974bc3632cebe3c6fbac8cbf34168f206274371e5271"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.19/browser-session-v0.1.19-x86_64-unknown-linux-musl.tar.gz"
      sha256 "66ca89eaa7297794f830d5f0acd9d0e5e3ca9928f8da0190376b8dce6059a43f"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.19/browser-session-v0.1.19-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8722d3b4ad9c52ee7b7413a5ecb2edc46bf9b99fb041ed45bbb4421654a2b442"
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
