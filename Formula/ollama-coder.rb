class OllamaCoder < Formula
  desc "Agentic coding assistant for Ollama - like Claude Code, but local!"
  homepage "https://github.com/lalomorales22/ollama-coder"
  url "https://files.pythonhosted.org/packages/de/74/a4b183469ba5327305a9d3a6f730bdde449906605cce103d441210c14fb9/ollama_coder-0.2.2.tar.gz"
  sha256 "747c4aabd8b2d2fd8c342b5ba773e7a820b0b4c9c6de773703cd567e273adc76"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Create empty venv structure - actual install happens in post_install
    # to avoid Homebrew's dylib relocation processing
    system "python3.11", "-m", "venv", libexec
    
    # Create wrapper script that will work after post_install completes
    (bin/"ollama-coder").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/ollama-coder" "$@"
    EOS
  end

  def post_install
    # Install packages AFTER Homebrew's library processing is complete
    # This avoids the pydantic-core dylib relocation error
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "--no-cache-dir", "ollama-coder==#{version}"
  end

  def caveats
    <<~EOS
      ollama-coder requires Ollama to be running.
      Start Ollama with: ollama serve
      
      Then run: ollama-coder
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/ollama-coder --help 2>&1", 0)
  end
end
