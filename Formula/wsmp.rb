class Wsmp < Formula
  desc "Command-line relay client for WS Model Proxy."
  homepage "https://github.com/FlyCockpit/ws-model-proxy"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.2/wsmp-aarch64-apple-darwin.tar.xz"
      sha256 "4b6da8727df4aaa957d28f472912c9fe2eae57dec438a2c4ddeb888650b458fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.2/wsmp-x86_64-apple-darwin.tar.xz"
      sha256 "b398baf96b18a8691eacb600c34d8f521be8af86431cf59dd877456b9dfcea8e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.2/wsmp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64fd717b792c90320131dcae3a8507366a7ab8af9e0c7d5b818d61fe7189c9a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FlyCockpit/ws-model-proxy/releases/download/v0.4.2/wsmp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5a81044ecc72bdc5024c6276620cfd98e18fbf921ca53c6dbf942cfd559c5b06"
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
