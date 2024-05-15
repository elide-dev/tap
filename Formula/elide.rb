class Elide < Formula
  desc "Fast, polyglot JVM-based runtime"
  homepage "https://elide.dev"
  version "1.0.0-alpha9"
  sha256 "1115002907d127f37dc8c819900aa432dd6438a9f0cc332a5e5f90550a213704"
  license "MIT"
  head "https://github.com/elide-dev/elide.git", using: :git
  url "https://github.com/elide-dev/elide/archive/refs/tags/1.0.0-alpha9.tar.gz"

  depends_on "xz"
  uses_from_macos "zlib"
  on_linux do
    depends_on "zlib"
    depends_on "glibc"
  end

  on_macos do
    on_arm do
      resource "elide_release" do
        url "https://github.com/elide-dev/elide/releases/download/1.0.0-alpha9/elide-1.0.0-alpha9-darwin-aarch64.txz"
        sha256 "7f758dfb3a429d0133ece5822e09a52b15e57d1d68eebb88de822844021ecabf"
      end
    end
    on_amd64 do
      resource "elide_release" do
        url "https://github.com/elide-dev/elide/releases/download/1.0.0-alpha9/elide-1.0.0-alpha9-darwin-amd64.txz"
        sha256 "f25e9199e74cd3f3870b8e2f87a559664cbf34e9196b1d6b0c9ab5b4bda858f4"
      end
    end
  end

  on_linux do
    on_amd64 do
      resource "elide_release" do
        url "https://github.com/elide-dev/elide/releases/download/1.0.0-alpha9/elide-1.0.0-alpha9-linux-amd64.tgz"
        sha256 "6da4fc41250789475fc3b77d8485ac9aecc784b636bffe0f45b59613f5abda7c"
      end
    end
    on_arm do
      resource "elide_release" do
        url "https://github.com/elide-dev/elide/releases/download/1.0.0-alpha9/elide-1.0.0-alpha9-linux-aarch64.tgz"
        sha256 "19b826d80c6306aca410ca75eee2dea14dcb907b158e3fd0e1ee35d8b71e8c51"
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
