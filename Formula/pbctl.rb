class Pbctl < Formula
  desc "Command-line interface to the MacOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0fdf8d970780c52589ff609c79bef0ca4228c495566214cacba82551e6c73a6f"
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
