class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.10/browser-session-v0.1.10-aarch64-apple-darwin.tar.gz"
      sha256 "003a98f3a060bdd0750de2381a7ffeb91f1ef72fcd690d5a15b73a3877d4d87a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.10/browser-session-v0.1.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f2797ee5fc868422e83bad2962e6b7331c91243629bee0937024a1b9362139b9"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.10/browser-session-v0.1.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ce984dd4c1d1f86c6e49ab1b4aa81737efc8684fbc9c4a61023452624e9c0df2"
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
