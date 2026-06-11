class Trestle < Formula
  desc "Local secret scanner for source code"
  homepage "https://trestlescan.com"
  license "Apache-2.0"

  stable do
    on_macos do
      on_arm do
        url "https://pkg.trestlescan.com/iN/5FUrW8RUBvJ2Js5fKDf9d3XJ/trestle-community-1.3.0-macos-apple-silicon"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.3.0/trestle-community-1.3.0-macos-apple-silicon"
        sha256 "2b84d149136d288526a666ad15fd9bdfe0f5bbedeaa21bb383adc00a60f7e8e7"
      end

      on_intel do
        url "https://pkg.trestlescan.com/iN/5FUrW8RUBvJ2Js5fKDf9d3XJ/trestle-community-1.3.0-macos-intel"
        mirror "https://github.com/toro-guapo/trestle/releases/download/v1.3.0/trestle-community-1.3.0-macos-intel"
        sha256 "0abe70c4d5d58161fd2d4fde620fc7dcebc09437599786280da1a284fe37916b"
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
    end
  end

  test do
    assert_match(/Trestle \w+ \d+\.\d+\.\d+/, shell_output("#{bin}/trestle --version"))
  end
end
