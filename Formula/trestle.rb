class Trestle < Formula
  desc "Local secret scanner for source code"
  homepage "https://trestlescan.com"
  license "Apache-2.0"

  stable do
    on_macos do
      on_arm do
        url "https://pkg.trestlescan.com/hG/kxL5Es4mRzrR1UUExtXJfH3U/trestle-community-1.4.0-macos-apple-silicon"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.0/trestle-community-1.4.0-macos-apple-silicon"
        sha256 "d1a90dbe0c66b053a2f12dd77bed4692a89bafb3aa1eb9371e02ebe6ca3ec545"
      end

      on_intel do
        url "https://pkg.trestlescan.com/hG/kxL5Es4mRzrR1UUExtXJfH3U/trestle-community-1.4.0-macos-intel"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.0/trestle-community-1.4.0-macos-intel"
        sha256 "ecabbfa8079d4a4f860a3dd85aaad1604a5bfbf06d559d20f79693e8cde1a11c"
      end
    end

    resource "trestle-net" do
      on_arm do
        url "https://pkg.trestlescan.com/hG/kxL5Es4mRzrR1UUExtXJfH3U/trestle-net-community-1.4.0-macos-apple-silicon"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.0/trestle-net-community-1.4.0-macos-apple-silicon"
        sha256 "62271bc01d66120360a6082a49b22efc38a72efa4af75b950d1c60c57db8e1df"
      end

      on_intel do
        url "https://pkg.trestlescan.com/hG/kxL5Es4mRzrR1UUExtXJfH3U/trestle-net-community-1.4.0-macos-intel"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.0/trestle-net-community-1.4.0-macos-intel"
        sha256 "df391dc033bf841d3af49f953369cb6231384bbcf3e5d0f8f65d9f681135b6b5"
      end
    end
  end

  head do
    url "https://github.com/toro-guapo/trestle.git", branch: "main"
    depends_on "rust" => :build
  end

  depends_on :macos

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install Dir["trestle-community-*"].first => "trestle"
      resource("trestle-net").stage do
        bin.install Dir["trestle-net-community-*"].first => "trestle-net"
      end
    end
  end

  test do
    assert_match(/Trestle \w+ \d+\.\d+\.\d+/, shell_output("#{bin}/trestle --version"))
    assert_match(/Trestle \w+ \d+\.\d+\.\d+/, shell_output("#{bin}/trestle-net --version"))
  end
end
