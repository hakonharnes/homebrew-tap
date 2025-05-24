class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.4.8.tar.gz"
  sha256   "3b178595a1763158c05260b91dfbff425ccf1402235321b742158e70e1874701"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  bottle do
    root_url "https://github.com/hakonharnes/homebrew-tap/releases/download/v0.4.7"
    rebuild 2
    sha256 cellar: :any, arm64_sequoia: "b7676b3cbb997674cec56013a65746b99fe7d5eebd6875ac2d96ef42f1d96c6c"
    sha256 cellar: :any, arm64_sonoma:  "4fc0941bcce89698ec22b19013f53871d8497abeb72e30b4e2118e3529debd07"
    sha256 cellar: :any, ventura:       "c282d47f19edaf192ee8dcf7d928309336510cc250106b676b8c04a7b9d91f86"
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
    assert_match "pbctl 0.4.8", shell_output("#{bin}/pbctl --version")
  end
end
