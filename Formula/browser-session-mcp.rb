class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.7/browser-session-v0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "100e5d17bd2786490a7117f31e51245f32c0505564b02156e6122cfcd380724f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.7/browser-session-v0.1.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7b85e7b5bd379d4b347f59219796f495b89db5510e44edd3d94600344401d9bc"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.7/browser-session-v0.1.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8318171d5eb0ab915c50218b3e9a9c3869d31249885b0840a79c38dd8116dbbe"
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
