class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.21/browser-session-v0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "a4b72030b595d2d8fe7b9de05199533d85bc4d5863608f870c3617aeb945d94c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.21/browser-session-v0.1.21-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4e41cf04bf1a7f0f1ee5f9e598c16f53e63925ea47accf452eea34bbf0740d47"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.21/browser-session-v0.1.21-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4eda6138ed12ae9fa9198c3cc035c9423e5fc25629285fbb28d806c6666367f8"
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
