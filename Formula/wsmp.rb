class Wsmp < Formula
  desc "Command-line relay client for WS Model Proxy."
  homepage "https://github.com/FlyCockpit/ws-model-proxy"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.1/wsmp-aarch64-apple-darwin.tar.xz"
      sha256 "3044b84da96f84ee7348fdb4b5b16a4498218fd12d9fd3005ce296d90d3301ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.1/wsmp-x86_64-apple-darwin.tar.xz"
      sha256 "de9fd7a218bce853eae0a56228014209cde50879cc2dca4615ff89d23a41b99c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.1/wsmp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9db382328e6b52f77f847b23c1917e6efb4692ce0d64fdba7a3944935b49d53c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.1/wsmp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5d15511af03be3a848cab3f802f96ae80c4525cf3d46bf02d5cf0076553c3ae"
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
