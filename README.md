# Data Generation Codebase for OpenAI GPT

This repository contains a set of Python scripts and utilities designed to facilitate the generation and processing of datasets for training machine learning models, specifically using OpenAI's GPT models.

## Overview

The codebase is structured to handle various steps in the dataset preparation process, from formatting prompts to sending API calls and processing responses. The tools included are ideal for researchers and developers looking to automate the preparation of training data for LLM SFT and RLHF training.

## Directory Structure

- `/jsons` - Directory where all script outputs in JSON format are stored.
- `/example_runs` - Contains example bash scripts demonstrating different use cases.

## Scripts

### Data Formatting

- `prompt_format.py`: Formats user input into a GPT-compatible format.

- `alpaca_formatting.py`: Formats data into a structure suitable for training purposes (Alpaca format).

- `split_response.py`: Splits prompts and responses for specific use cases depending on the stage of data generation.

- `trim_response.py`: Trims and cleans the messages.

- `preference_format.py`: Formats data into a format suitable for RLHF by marking chosen/rejected features suitable for RLHF tuning.

### API Interaction

- `response_gpt.py`: Handles API calls to generate prompts/responses using multithreading for efficiency.

## Example Bash Scripts

Located in `/example_runs`, these scripts demonstrate practical applications of the tools:

- Bash script for generating 'rejected' data for the RLHF dataset.
- A script for generating multiple responses for a single prompt.
- A script for generating prompts first, then responses for a QA dataset.

## Setup and Execution

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/lightmatmul/Data-Generation-with-OpenAI.git
   cd Data-Generation-with-OpenAI```

2. **Create and activate a virtual environment:**
   ```bash
   python -m venv env
   source env/bin/activate  # On Windows, use `env\Scripts\activate```

3. **Install the required packages:**
   ```bash
   pip install -r requirements.txt```

### API key setup

Ensure you have an OpenAI API key, which you will need to insert into `response_gpt.py`.

### Permissions

Before running the scripts, set the necessary permissions using the following command for each bash script:

```bash
chmod +x script.sh
# Then run:
./script.sh
```

