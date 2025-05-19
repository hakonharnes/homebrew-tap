class Pbctl < Formula
  desc "Command-line interface to the MacOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "70a48c56ed0b38d2e28e484d6f2b9d4a17f69da98cfa2a738fe6074454172736"
  license "MIT"
  head "https://github.com/hakonharnes/pbctl.git", branch: "main"

  depends_on :macos
  depends_on "swift"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/pbctl"
  end

  test do
    system "#{bin}/pbctl", "--version"
  end
end
