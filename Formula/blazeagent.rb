class Blazeagent < Formula
  desc "Local-first AI coding agent with deterministic routing"
  homepage "https://github.com/Mikedan37"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/Mikedan37/blaze-releases/releases/download/v0.1.0/blaze-0.1.0-arm64-macos.tar.gz"
      sha256 "bc37f5d721aa6b98e94c44ec67e23d08094d32f585740d4d855f16899f5a07fc"
    end
  end

  def install
    bin.install "blaze"
    bin.install "blaze-daemon"
    bin.install "com.blaze.agentdaemon.plist"
    bin.install "blaze-post-install.sh"
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
    assert_match "blaze", shell_output("#{bin}/blaze --help 2>&1", 0)
  end
end
