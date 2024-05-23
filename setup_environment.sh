#!/bin/bash

# Check if Homebrew is installed, and install it if it's not
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found, installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

# Reinstall Python using Homebrew
echo "Reinstalling Python with Homebrew..."
brew reinstall python

# Remove existing virtual environment if it exists
if [ -d ".venv" ]; then
    echo "Removing existing virtual environment..."
    rm -rf .venv
fi

# Create a new virtual environment
echo "Creating a new virtual environment..."
python3 -m venv .venv

# Activate the virtual environment
echo "Activating the virtual environment..."
source .venv/bin/activate

# Install PortAudio using Homebrew
echo "Installing PortAudio with Homebrew..."
brew install portaudio

# Export necessary environment variables
export CPATH=/usr/local/include
export LIBRARY_PATH=/usr/local/lib

# Install distutils if it's missing
if ! python -c "import distutils" &> /dev/null; then
    echo "distutils not found, installing distutils..."
    python -m ensurepip
    pip install --upgrade pip
else
    echo "distutils is already installed"
fi

# Install project dependencies
if [ -f "requirements.txt" ]; then
    echo "Installing project dependencies from requirements.txt..."
    pip install -r requirements.txt
else
    echo "requirements.txt not found, please ensure it exists in the project directory."
fi

echo "Setup complete. If there were no errors, your environment should be ready to use."
