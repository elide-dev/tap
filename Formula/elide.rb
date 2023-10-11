class Elide < Formula
  desc "Fast, polyglot JVM-based runtime"
  homepage "https://elide.dev"
  version "1.0.0-alpha7"
  url "https://github.com/elide-dev/releases/archive/refs/tags/1.0.0-alpha7.tar.gz"
  sha256 "6f9d8781782841c8a3f1c056fe359fae7271f72e469869c1c72ea22bd9ad580c"
  license "MIT"

  def install
    system "./gradlew", ":packages:cli:nativeOptimizedCompile", "-Pelide.release=true", "-Pelide.buildMode=opt"
  end

  test do
    system "#{bin}/elide", "--version"
    system "#{bin}/elide", "info"
    system "#{bin}/elide", "selftest"
  end
end

