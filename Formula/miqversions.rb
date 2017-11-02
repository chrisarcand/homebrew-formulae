require "formula"
require "language/go"

class Miqversions < Formula
  desc "Because naming is hard. Really, really hard."
  homepage "https://github.com/chrisarcand/miqversions"
  url "https://github.com/chrisarcand/miqversions/archive/v1.0.2.tar.gz"
  sha256 "98ca65fd959688610acddedabb435298433a1eddd6b87693cc278a96c9237063"

  head "https://github.com/chrisarcand/miqversions.git"

  bottle do
    root_url "https://github.com/chrisarcand/miqversions/releases/download/v1.0.2"
    cellar :any_skip_relocation
    sha256 "a1ee66dec58af47a9a49944063dc24e0915bd660699580455fafd13cdc7234e6" => :sierra
  end

  go_resource "github.com/olekukonko/tablewriter" do
    url "https://github.com/olekukonko/tablewriter.git",
      :revision => "febf2d34b54a69ce7530036c7503b1c9fbfdf0bb"
  end

  go_resource "github.com/mattn/go-runewidth" do
    url "https://github.com/mattn/go-runewidth.git",
      :revision => "97311d9f7767e3d6f422ea06661bc2c7a19e8a5d"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    # set up package
    (buildpath/"src/github.com/chrisarcand/miqversions").install Dir["{*,.git}"]

    # set up dependencies
    Language::Go.stage_deps resources, buildpath/"src"

    # install command
    system(
      "go",
      "build",
      "-o", bin/"miqversions",
      "-v",
      "github.com/chrisarcand/miqversions"
    )
  end
end
