#!/bin/bash
curl -fsSL https://claude.ai/install.sh | bash
ollama pull jaahas/crow:latest
ollama launch claude --model jaahas/crow:latest
