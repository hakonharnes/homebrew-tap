class Glint < Formula
  desc "Lightweight window borders for macOS, inspired by Hyprland"
  homepage "https://github.com/hakonharnes/homebrew-tap"
  url "https://github.com/hakonharnes/homebrew-tap/releases/download/glint-v0.3.2/glint-0.3.2-macos.tar.gz"
  sha256 "209e99081519fc6cbb5ecc8d9b7a5a65980b77b991f47ff8797dd439bb5e1c9d"
  version "0.3.2"

  depends_on macos: :sonoma

  def install
    # glint is an app, so macOS shows it with its logo and keeps one entry for it
    # under Accessibility; the command links into it.
    prefix.install "glint.app"
    bin.install_symlink prefix/"glint.app/Contents/MacOS/glint"
    man1.install "glint.1"
    zsh_completion.install "_glint" if File.exist?("_glint")
    bash_completion.install "glint.bash" => "glint" if File.exist?("glint.bash")
    fish_completion.install "glint.fish" if File.exist?("glint.fish")
    doc.install Dir["doc/*"] if File.directory?("doc")
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

      Settings: ~/.config/glint/glintrc, the menu bar item, or `glint preferences`.
      Scripting (list-windows, set, subscribe, hooks): `glint --help`, `man glint`,
      and #{doc}/scripting.md.
      Coming from hairline, its settings are copied over the first time glint runs.
    EOS
  end

  test do
    assert_match "glint #{version}", shell_output("#{bin}/glint --version")
    assert_match "theme=", shell_output("#{bin}/glint --help")
    assert_match "%{window-id}", shell_output("#{bin}/glint list-windows --help")
  end
end
