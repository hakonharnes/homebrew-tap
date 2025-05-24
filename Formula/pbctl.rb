class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.4.2.tar.gz"
  sha256   "7f39dcab0eea8556e673dea0215c4b6aec99e6c84dd31bc64c1f7e73613d67c0"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  depends_on :macos
  depends_on "swift" => :build

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
    assert_match "pbctl 0.4.2", shell_output("#{bin}/pbctl --version")
  end
end
