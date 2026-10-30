class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.15/browser-session-v0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "204cebe28dc23196f6d0f4164079f2ea1a4bf4c66e121efaa5c5afb9f01f7930"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.15/browser-session-v0.1.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "41e03f6c16c2244c1fe64ef7c9a511e7980b0c0d923bb1f93be9a34cfe2d9369"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.15/browser-session-v0.1.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f14955a1a5dac4246868a7977368fb85e658d6acabef3286946754211fecd322"
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
