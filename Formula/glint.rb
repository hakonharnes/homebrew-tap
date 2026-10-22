class Glint < Formula
  desc "Lightweight window borders for macOS, inspired by Hyprland"
  homepage "https://github.com/hakonharnes/homebrew-tap"
  url "https://github.com/hakonharnes/homebrew-tap/releases/download/glint-v0.1.1/glint-0.1.1-macos.tar.gz"
  sha256 "e07ac8bdab1b6cfd2163c1b7346cc9fb9bbaa9f14cfe60ee55a9ce9cfccf5b68"
  version "0.1.1"

  depends_on macos: :sonoma

  def install
    bin.install "glint"
    man1.install "glint.1"
  end

  service do
    run [opt_bin/"glint"]
    keep_alive true
    process_type :interactive
    log_path var/"log/glint.log"
    error_log_path var/"log/glint.log"
  end

  def caveats
    <<~EOS
      Start glint now and at every login:
        brew services start glint

      glint asks for Accessibility access to know which window has focus:
        System Settings → Privacy & Security → Accessibility
      After an upgrade macOS may need it granted again (remove glint there and add it back).

      Settings: ~/.config/glint/glintrc, the menu bar item, or `glint preferences`.
      Coming from hairline, its settings are copied over the first time glint runs.
    EOS
  end

  test do
    assert_match "glint #{version}", shell_output("#{bin}/glint --version")
    assert_match "theme=", shell_output("#{bin}/glint --help")
  end
end
