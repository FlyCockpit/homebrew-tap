class Wsmp < Formula
  desc "Command-line relay client for WS Model Proxy."
  homepage "https://github.com/FlyCockpit/ws-model-proxy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.1.0/wsmp-aarch64-apple-darwin.tar.xz"
      sha256 "1a1cf88369f42ea1f2575096a9490630607173010511d3e41f47f85417fcc258"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.1.0/wsmp-x86_64-apple-darwin.tar.xz"
      sha256 "8b1b9e888d4675cd646eed548199eafb81c6b1e9d1238c78751d69f6d6320aef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.1.0/wsmp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e6deb6f0ee84dafaf4bac000ba0df4c23df414a0f6f0d135eccd0fff1f9db36e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.1.0/wsmp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bba079b4d19b133e946d78a953b61aa0c48492a0bf4f2b7336f63b7eafb084af"
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
