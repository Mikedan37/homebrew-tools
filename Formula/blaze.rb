class Blaze < Formula
  desc "Local-first AI coding agent with deterministic routing"
  homepage "https://github.com/Mikedan37"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/Mikedan37/blaze-releases/releases/download/v0.1.0/blaze-0.1.0-arm64-macos.tar.gz"
      sha256 "6804b0c8266006b91aa4a399afa04fb6509d795873fed902aa4b627a0442a005"
    end
  end

  def install
    bin.install "bin/blaze"
    bin.install "bin/blaze-daemon"
    bin.install "bin/com.blaze.agentdaemon.plist"
    bin.install "bin/blaze-post-install.sh"
  end

  def post_install
    system "#{bin}/blaze-post-install.sh"
  end

  def caveats
    <<~EOS
      Blaze requires Ollama for local AI inference:
        brew install ollama
        ollama pull qwen2.5-coder:7b

      Or set your Anthropic API key for cloud inference:
        export ANTHROPIC_API_KEY="your-key"

      The Blaze daemon runs automatically via launchd.
      To verify: blaze run "your goal" --auto --direct
    EOS
  end

  test do
    assert_match "blaze", shell_output("#{bin}/blaze --version")
  end
end
