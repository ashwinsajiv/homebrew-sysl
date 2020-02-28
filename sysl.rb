require 'rubygems/package'
require 'zlib'

class Sysl < Formula
  desc "Sysl (pronounced \"sizzle\") is a system specification language"
  homepage "https://sysl.io"
  url "https://github.com/ashwinsajiv/sysl/archive/v0.8.0.tar.gz"
  sha256 "586be97749140d87d071a0a8e7aa5e2c0dd7b67672875f367cd44078447cdf48"
  TAR_LONGLINK = '././@LongLink'
  def install
	tar_gz_archive = File.join('/', 'Users', ENV['USER'], 'Library', 'Caches', 'Homebrew', 'sysl--0.7.0.tar.gz')
	destination = File.join('/', 'Users', ENV['USER'], 'Library', 'Caches', 'Homebrew')

	Gem::Package::TarReader.new( Zlib::GzipReader.open tar_gz_archive ) do |tar|
	  dest = nil
	  tar.each do |entry|
	    if entry.full_name == TAR_LONGLINK
	      dest = File.join destination, entry.read.strip
	      next
	    end
	    dest ||= File.join destination, entry.full_name
	    if entry.directory?
	      File.delete dest if File.file? dest
	      FileUtils.mkdir_p dest, :mode => entry.header.mode, :verbose => false
	    elsif entry.file?
	      FileUtils.rm_rf dest if File.directory? dest
	      File.open dest, "wb" do |f|
	        f.print entry.read
	      end
	      FileUtils.chmod entry.header.mode, dest, :verbose => false
	    elsif entry.header.typeflag == '2' #Symlink!
	      File.symlink entry.header.linkname, dest
	    end
	    dest = nil
	  end
	end
    system "ruby", "sysl-install.rb"
  end
end
