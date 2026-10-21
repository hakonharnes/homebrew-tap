class Glint < Formula
  desc "Lightweight window borders for macOS, inspired by Hyprland"
  homepage "https://github.com/hakonharnes/homebrew-tap"
  url "https://github.com/hakonharnes/homebrew-tap/releases/download/glint-v0.1.0/glint-0.1.0-macos.tar.gz"
  sha256 "5b63d7f2a376ce1ca46604b06783bdbc1b7e39b9564e815af6b6e1b32c0ba631"
  version "0.1.0"

  depends_on :macos
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
