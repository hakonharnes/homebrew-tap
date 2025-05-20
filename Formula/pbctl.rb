class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256   "7cae141577b2b74cd8245527bac3ab483e2e342084de73e29bce7e859a0b7706"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    libexec.install Dir[".build/release/pbctl"]
    libexec.install Dir[".build/release/*MagicWrapper*.bundle"]
    (bin/"pbctl").write <<~SH
      #!/usr/bin/env bash
      exec "#{libexec}/pbctl" "$@"
    SH
  end

  test do
    assert_match "pbctl", shell_output("#{bin}/pbctl --version")
  end
end
