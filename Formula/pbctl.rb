class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.3.2.tar.gz"
  sha256   "a3719e0fa76e8a8f5299e300b95572bcf741e53ed73f0e5179395d4cd94e7bbc"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"

    libexec.install ".build/release/pbctl"
    libexec.install ".build/release/CLibmagic_MagicWrapper.bundle"

    (bin/"pbctl").write <<~SH
      #!/bin/bash
      exec "#{libexec}/pbctl" "$@"
    SH
  end

  test do
    assert_match "pbctl 0.3.2", shell_output("#{bin}/pbctl --version")
  end
end
