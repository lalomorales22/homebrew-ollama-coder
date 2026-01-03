class OllamaCoder < Formula
  include Language::Python::Virtualenv

  desc "Agentic coding assistant for Ollama - like Claude Code, but local!"
  homepage "https://github.com/lalomorales22/ollama-coder"
  url "https://files.pythonhosted.org/packages/de/74/a4b183469ba5327305a9d3a6f730bdde449906605cce103d441210c14fb9/ollama_coder-0.2.2.tar.gz"
  sha256 "747c4aabd8b2d2fd8c342b5ba773e7a820b0b4c9c6de773703cd567e273adc76"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Create virtualenv
    venv = virtualenv_create(libexec, "python3.11", system_site_packages: false)
    
    # Use system pip install with dependencies (venv.pip_install uses --no-deps)
    system libexec/"bin/python", "-m", "pip", "install", "ollama-coder==0.2.2"
    
    # Link the binary
    bin.install_symlink libexec/"bin/ollama-coder"
  end

  test do
    assert_match "OllamaCoder", shell_output("#{bin}/ollama-coder --help")
  end
end
