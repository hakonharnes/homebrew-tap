class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/null.tar.gz"
  sha256   "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  bottle do
    root_url "https://github.com/hakonharnes/homebrew-tap/releases/download/v0.4.8"
    rebuild 3
    sha256 cellar: :any, arm64_sequoia: "18b27762837cd3475fb19d9c30a27ad9c47da87e8998532d1543a97d2696b365"
    sha256 cellar: :any, arm64_sonoma:  "25ef8a4a2169c16884817d16d2a0d68fd798c52fde503ecd66fceee4adf32952"
    sha256 cellar: :any, ventura:       "8f07915195a617a4ae20f97e3f51da04634fb3dd4a5d45ae81a14d6159777839"
  end

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
    assert_match "pbctl null", shell_output("#{bin}/pbctl --version")
  end
end
