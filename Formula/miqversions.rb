require 'formula'
require 'language/go'

class Miqversions < Formula
  desc "Because naming is hard. Really, really hard."
  homepage "https://github.com/chrisarcand/miqversions"
  url "https://github.com/chrisarcand/miqversions/archive/v1.0.0-pre1.tar.gz"
  sha256 "8ed8d32e8e0046ed0208919089c81f60a00f477d40e819415c5be3ea6dcae42e"

  depends_on "go" => :build

  go_resource "github.com/olekukonko/tablewriter" do
    url "https://github.com/olekukonko/tablewriter.git",
      :revision => "febf2d34b54a69ce7530036c7503b1c9fbfdf0bb"
  end

  def install
    ENV["GOPATH"] = buildpath

    # set up package
    (buildpath/"src/github.com/chrisarcand/miqversions").install Dir["*"]

    # set up dependencies
    Language::Go.stage_deps resources, buildpath/"src"

    # install command
    system(
      "go",
      "build",
      "-o", bin/"miqversions",
      "-v",
      "github.com/chrisarcand/miqversions",
    )
  end
end
