cask "ngrok" do
  arch arm: "arm64", intel: "amd64"

  on_arm do
    version "3.2.1,ieMpdKGZc6g,a"
    sha256 "896f37cff976229b39392916f23403349c350f871cb63677cb6b4fbafb97faee"
  end
  on_intel do
    version "3.2.2,hoFbK2Q2jz3,a"
    sha256 "707bea6a294413e6d39edcb3f131846bccdb1a00d4fb2ed2a8f2cb5aa94da231"
  end

  url "https://bin.equinox.io/#{version.csv.third}/#{version.csv.second}/ngrok-v#{version.major}-#{version.csv.first}-stable-darwin-#{arch}.zip",
      verified: "bin.equinox.io/"
  name "ngrok"
  desc "Reverse proxy, secure introspectable tunnels to localhost"
  homepage "https://ngrok.com/"

  livecheck do
    url "https://dl.equinox.io/ngrok/ngrok-v#{version.major}/stable/archive"
    regex(%r{href=.*?/([^/]+)/([^/]+)/ngrok[._-]v#{version.major}[._-]v?(\d+(?:\.\d+)+)[._-]darwin[._-]#{arch}\.zip}i)
    strategy :page_match do |page|
      page.scan(regex).map { |match| "#{match[2]},#{match[1]},#{match[0]}" }
    end
  end

  binary "ngrok"

  postflight do
    set_permissions "#{staged_path}/ngrok", "0755"
  end

  zap trash: [
    "~/.ngrok#{version.major}",
    "~/Library/Application Support/ngrok",
  ]
end
