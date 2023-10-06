class Nubesgen < Formula
  desc "Kickstart your project on Azure in minutes!"
  homepage "https://nubesgen.com/"
  url "https://github.com/microsoft/NubesGen/releases/download/v0.17.0/nubesgen-cli-0.3.0-SNAPSHOT.jar"
  version "0.17.0"
  sha256 "6e8ee4fc4bc887f1741bcf758475f50f7cf0f706e91c74a80c541e7f9da2f06c"
  license "MIT"

  depends_on "azure-cli"
  depends_on "gh"
  depends_on "openjdk"

  def install
    libexec.install "nubesgen-cli-0.3.0-SNAPSHOT.jar" => "nubesgen-#{version}.jar"

    # Force using the openjdk dependency
    (bin/"nubesgen").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="#{Language::Java.java_home_env[:JAVA_HOME]}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/nubesgen-#{version}.jar" "$@"
    EOS
  end

  test do
    s = pipe_output("#{bin}/nubesgen -h")
    assert_match "CLI for NubesGen.com", s
  end
end
