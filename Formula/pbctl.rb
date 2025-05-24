class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.4.1.tar.gz"
  sha256   "093368138091848c6877d10bdd758d65ef4b2cf0ea78d50c60c980891a60f57f"
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
    assert_match "pbctl 0.4.1", shell_output("#{bin}/pbctl --version")
  end
end
