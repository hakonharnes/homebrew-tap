class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.3.4.tar.gz"
  sha256   "4d0566a19e2733a7dec35e3ea265b2f4ac9d5826a69fee74af080b48d71c67e8"
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
    assert_match "pbctl 0.3.4", shell_output("#{bin}/pbctl --version")
  end
end
