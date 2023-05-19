import subprocess
import os

def run_command(command):
    process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    output, error = process.communicate()

    if error:
        print(f"Error occurred: {error}")
    else:
        print(output.decode())

# Update package lists
run_command("apt update")

# Install cargo
run_command("apt install -y cargo")

# Create the directory where everything will be installed
run_command("mkdir -p /opt/chainsaw")

# Change to the installation directory
os.chdir("/opt/chainsaw")

# Clone chainsaw repository
run_command("git clone https://github.com/countercept/chainsaw.git")

# Change directory to chainsaw
os.chdir("chainsaw")

# Build chainsaw
run_command("cargo build --release")

# Move chainsaw binary to /usr/local/bin to make it globally accessible
run_command("mv ./target/release/chainsaw /usr/local/bin/")

# Change directory back to /opt/chainsaw
os.chdir("/opt/chainsaw")

# Clone Sigma and EVTX-ATTACK-SAMPLES repositories
run_command("git clone https://github.com/SigmaHQ/sigma.git")
run_command("git clone https://github.com/sbousseaden/EVTX-ATTACK-SAMPLES.git")

# Check chainsaw version
run_command("chainsaw --version")
