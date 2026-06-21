class Trestle < Formula
  desc "Local secret scanner for source code"
  homepage "https://trestlescan.com"
  license "Apache-2.0"

  stable do
    on_macos do
      on_arm do
        url "https://pkg.trestlescan.com/Nz/iVXTx2BehnsdEga1RidS8c2u/trestle-community-1.4.1-macos-apple-silicon"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.1/trestle-community-1.4.1-macos-apple-silicon"
        sha256 "c48e829c0be3029ecb565841f7f0f231edc79594419b425bad3d9484975a7588"
      end

      on_intel do
        url "https://pkg.trestlescan.com/Nz/iVXTx2BehnsdEga1RidS8c2u/trestle-community-1.4.1-macos-intel"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.1/trestle-community-1.4.1-macos-intel"
        sha256 "0e1669c7e9d7a3773ac93dfd02d22a52650aecc7da134140f5e51830af09cce8"
      end
    end

    resource "trestle-net" do
      on_arm do
        url "https://pkg.trestlescan.com/Nz/iVXTx2BehnsdEga1RidS8c2u/trestle-net-community-1.4.1-macos-apple-silicon"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.1/trestle-net-community-1.4.1-macos-apple-silicon"
        sha256 "3592b2449c30b75002c411dc084e3b68f412dd5f3bfa614753eea891cbc5ac93"
      end

      on_intel do
        url "https://pkg.trestlescan.com/Nz/iVXTx2BehnsdEga1RidS8c2u/trestle-net-community-1.4.1-macos-intel"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.4.1/trestle-net-community-1.4.1-macos-intel"
        sha256 "87d28b4aa029dea95393c61d44d658f345897a5f7654fbdb53f4fb74d02edd53"
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
