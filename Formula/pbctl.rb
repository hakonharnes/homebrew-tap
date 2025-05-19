class Pbctl < Formula
  desc "Command-line interface to the MacOS pasteboard"
  homepage "https://github.com/hakonharnes/pbctl"
  url "https://github.com/hakonharnes/pbctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "7cae141577b2b74cd8245527bac3ab483e2e342084de73e29bce7e859a0b7706"
  license "MIT"
  head "https://github.com/hakonharnes/pbctl.git", branch: "main"

  bottle do
    root_url "https://github.com/hakonharnes/homebrew-tap/releases/download/pbctl-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "PLACEHOLDER_HASH"
    sha256 cellar: :any_skip_relocation, ventura: "PLACEHOLDER_HASH"
    sha256 cellar: :any_skip_relocation, monterey: "PLACEHOLDER_HASH"
  end

  depends_on :macos
  depends_on "swift"
  depends_on "libmagic"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/pbctl"
    
    # Ensure resources are properly installed
    bundle_path = Dir.glob(".build/**/release/CLibmagic_MagicWrapper.bundle").first
    if bundle_path
      prefix.install bundle_path
    end
  end

  test do
    system "#{bin}/pbctl", "--version"
  end
end
