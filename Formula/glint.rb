class Glint < Formula
  desc "Lightweight window borders for macOS, inspired by Hyprland"
  homepage "https://github.com/hakonharnes/homebrew-tap"
  url "https://github.com/hakonharnes/homebrew-tap/releases/download/glint-v0.1.4/glint-0.1.4-macos.tar.gz"
  sha256 "8cb2719fa78e46b45f613a3d9b042e8c4d11e8815bde369deff4b3b78cbfedd8"
  version "0.1.4"

  depends_on macos: :sonoma

  def install
    bin.install "glint"
    man1.install "glint.1"
    zsh_completion.install "_glint" if File.exist?("_glint")
    bash_completion.install "glint.bash" => "glint" if File.exist?("glint.bash")
    fish_completion.install "glint.fish" if File.exist?("glint.fish")
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
