class BrowserSessionMcp < Formula
  desc "Isolated, long-lived Chrome sessions for AI agents over MCP"
  homepage "https://github.com/xav-ie/browser-session-mcp"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.11/browser-session-v0.1.11-aarch64-apple-darwin.tar.gz"
      sha256 "2a8ce6b75cb1129e6bb05a7c942bde6aa8878ba75003729dc845950ff50058a5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.11/browser-session-v0.1.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f1a2d6bcebfa5165933414853272097137d4a934c92e50fcd1f93af007d48529"
    end
    on_arm do
      url "https://github.com/xav-ie/browser-session-mcp/releases/download/v0.1.11/browser-session-v0.1.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "db6b477fc4e41a73e9240d4b73256f6f5b286b1c42d2fc7609480079c9e2634e"
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
