class Wsmp < Formula
  desc "Command-line relay client for WS Model Proxy."
  homepage "https://github.com/FlyCockpit/ws-model-proxy"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.1/wsmp-aarch64-apple-darwin.tar.xz"
      sha256 "96252b727a0756ce15fbf8c560d3f75e80742663b31a07ccf99049e65b2e3e73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.1/wsmp-x86_64-apple-darwin.tar.xz"
      sha256 "c4b67a7e2cd071103417777b1ec365249ea1baef4c06a0a65043dda704c21d3e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.1/wsmp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b8c5187aa102fdf200f3ab65f1f6dc458474bdd596858a463842fbedc1bd843"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.1/wsmp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c80280889f79b684eede0df1bbc8b1df7b5c513d9fe2cb81d720ed0517e6b53"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "wsmp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "wsmp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "wsmp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "wsmp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
