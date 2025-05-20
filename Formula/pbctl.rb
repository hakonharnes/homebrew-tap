class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.1.3.tar.gz"
  sha256   "9cffca3b832da87b07ecbd66e2bbeacf3d14705f26a651198d2eb1a8911b7168"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    libexec.install ".build/release/pbctl"
    libexec.install ".build/release/*MagicWrapper*.bundle"
    (bin/"pbctl").write <<~SH
      #!/usr/bin/env bash
      exec "#{libexec}/pbctl" "$@"
    SH
  end

  test do
    assert_match "pbctl", shell_output("#{bin}/pbctl --version")
  end
end
