class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.17/browser-session-v0.1.17-aarch64-apple-darwin.tar.gz"
      sha256 "ef699950d4b5079ac39ec664efda7527c0dbd3a99a355fd3959776396cf9ce73"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.17/browser-session-v0.1.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e06745d01e8c4b7de2919dbf6d67597afa2e3dcc9f82d585adc7678daea9a464"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.17/browser-session-v0.1.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ab49d1a57dff14142ee2a2785e164accc784f247206a14ef7d172ff8c76469c6"
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
