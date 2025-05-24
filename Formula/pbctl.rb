class Pbctl < Formula
  desc     "Command-line interface to the macOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url      "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.4.4.tar.gz"
  sha256   "79acbdf9af1d86410b3f3f911554497de7382f395f9a460436d30512b62f6d88"
  license  "MIT"
  head     "https://github.com/hakonharnes/pbctl.git", branch: "main"

  bottle do
    root_url "https://github.com/hakonharnes/homebrew-tap/releases/download/v0.4.3"
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "3024910ba6918505edeedcf2b20d9ec9f5ec10b8614aa967e2af76950923538c"
    sha256 cellar: :any, arm64_sonoma:  "523cbfa4cc3b1208702ea147c4f70dbf4bb54314c7e9aa4ca5ee08d87a2297c8"
    sha256 cellar: :any, ventura:       "8c43a32494b4056325309c2661021492c7607035dc02bd51c481593238cdbc76"
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
    assert_match "pbctl 0.4.4", shell_output("#{bin}/pbctl --version")
  end
end
