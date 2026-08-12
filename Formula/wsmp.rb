class Wsmp < Formula
  desc "Command-line relay client for WS Model Proxy."
  homepage "https://github.com/FlyCockpit/ws-model-proxy"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.0/wsmp-aarch64-apple-darwin.tar.xz"
      sha256 "ff164af197768d9fbf08dffefd689b78de89dbc92764ae8bbf0142b0cbf4fdd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.0/wsmp-x86_64-apple-darwin.tar.xz"
      sha256 "2fe488db2fb7c4701d1fc676aa7ca7baf6697dba327d09d6f05996f55894f516"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.0/wsmp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b84e7b15735514a534824d345fbe2c6ae493861ec3a5e02da0c6a2d8705b17cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.3.0/wsmp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5ab48d938a8994ce0db6b43c60b107473e541627675b400ee5f119d8fe5ac1d"
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
