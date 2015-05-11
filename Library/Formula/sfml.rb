class Sfml < Formula
  homepage "http://www.sfml-dev.org/"

  stable do
    url "http://www.sfml-dev.org/download/sfml/2.2/SFML-2.2-sources.zip"
    sha1 "b21721a3dc221a790e4b81d6ba358c16cb1c1cd3"

    # Patch to support removing the extlibs dir which caused install_name_tool complications.
    # Already merged in HEAD and will be in the next release.
    patch do
      url "https://github.com/LaurentGomila/SFML/commit/9f2aecf9cff75307.diff"
      sha1 "87646d34cf0315c814ca6313cf75bb0439113eef"
    end
  end

  head "https://github.com/LaurentGomila/SFML.git"

  depends_on "cmake" => :build
  depends_on "freetype"
  depends_on "glew"
  depends_on "jpeg"
  depends_on "libsndfile"
  depends_on "doxygen" => :optional

  def install
    args = std_cmake_args
    args << "."

    args << "-DSFML_BUILD_DOC=TRUE" if build.with? "doxygen"

    # Always remove the "extlibs" to avoid install_name_tool failure.
    # https://github.com/Homebrew/homebrew/pull/35279
    rm_rf buildpath/"extlibs"

    system "cmake", *args
    system "make", "install"
  end
end
