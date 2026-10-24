class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.5/browser-session-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "cfe351becc2f728c9ef01d9bcf14f969062161235a42b0cb069979827ffe4aa7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.5/browser-session-v0.1.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "956356b025978f282e83e71088b5e21141f70e4588f5464da6774dea3e2d80dc"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.5/browser-session-v0.1.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bed18bd3a4294fe79998817aa74add68233d11d0cd0ba46eb2d2073e56da6b3f"
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
