class Elide < Formula
  desc "Fast, polyglot JVM-based runtime"
  homepage "https://elide.dev"
  version "1.0.0-alpha7"
  sha256 "1115002907d127f37dc8c819900aa432dd6438a9f0cc332a5e5f90550a213704"
  license "MIT"
  head "https://github.com/elide-dev/elide.git", using: :git
  url "https://github.com/elide-dev/elide/archive/refs/tags/1.0.0-alpha7.tar.gz"

  depends_on "xz"
  uses_from_macos "zlib"
  on_linux do
    depends_on "zlib"
    depends_on "glibc"
  end

  on_macos do
    on_arm do
      resource "elide_release" do
        url "https://github.com/elide-dev/releases/releases/download/1.0.0-alpha7/elide.darwin-aarch64.txz"
        sha256 "d6fc9ab7e189b9c755b5f488b45eb74596ef75d280d8c930d2914b06684ccc0b"
      end
    end
  end

  on_linux do
    on_amd64 do
      resource "elide_release" do
        url "https://github.com/elide-dev/releases/releases/download/1.0.0-alpha7/elide.linux-amd64.txz"
        sha256 "f75a1d9ecb4c53d2041480d4ca8d329c893e3ad5c09023560b4d5e8b34d34e10"
      end
    end
  end

  def install
    (buildpath/"build").install resource("elide_release")
    cd "build" do
      prefix.install "elide"
      prefix.install Dir["resources"]
      bin.install_symlink prefix/"elide"
      system "mkdir", "-p", "~/.elide"
  
      if OS.linux?
        lib.install "*.so"
      end
    end
  end

  test do
    system "#{bin}/elide", "--version"
    system "#{bin}/elide", "info"
    system "#{bin}/elide", "selftest"
  end
end
