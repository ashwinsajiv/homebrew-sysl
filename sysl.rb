class Sysl < Formula
  desc "Sysl (pronounced \"sizzle\") is a system specification language"
  homepage "https://sysl.io"
  url "https://github.com/ashwinsajiv/sysl/archive/v0.5.0.tar.gz"
  sha256 "aeb96e60899f4af978abdd92fff027718f77d07da2d42c22cf6b92b56142487d"

  def install
    system "ruby", "sysl-install.rb"
  end
end
