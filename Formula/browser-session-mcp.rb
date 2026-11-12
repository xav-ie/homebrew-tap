class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.22/browser-session-v0.1.22-aarch64-apple-darwin.tar.gz"
      sha256 "043c68505784c5ec10f9b76a61f64e4076a811e3e56f686aa8daaa37a17fe2c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.22/browser-session-v0.1.22-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d4fae75c8bddcb4235f8185c3ead2ad9d4e4c84a22430489ddec760a1d902910"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.22/browser-session-v0.1.22-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6a2d04c6a6f728b6b482bd1a89438b5e67fa2c168574bbd5237cea0017fa1517"
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
