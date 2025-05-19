class Pbctl < Formula
  desc "Command-line interface to the MacOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "7cae141577b2b74cd8245527bac3ab483e2e342084de73e29bce7e859a0b7706"
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
