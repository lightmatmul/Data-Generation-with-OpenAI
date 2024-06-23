#!/bin/bash

## Parent directory
cd ..

## Phase I: prep rlhf data
python3 trim_response.py -input_json rlhf_asked -trim_blanks
python3 split_response.py -input_json rlhf_trimmed -new_key "instruction"

## Phase II: Generate bad GPT answers
first_prompt=$(cat <<'EOF'

## SYSTEM INSTRUCTION:
You are a dataset generator. You will be given context for what kind of data you want to generate. Your goal is to generate the dataset with the goal of it being used within a fine-tune.\n 

## USER INSTRUCTION:
Based on this instruction: '{instruction}'. provide a response that correctly solves the instruction but does NOT explain (or incomplete) the reasoning or steps involved. We want to build an RLHF dataset of good and bad responses, where the good responses adopt step by step reasoning and where the bad responses are not as detailed/ incomplete and are shorter as they are more straightforward. Thus, I am asking you to generate the bad response.
EOF
)

assistant_prompt=$(cat <<'EOF'
EOF
)
python3 prompt formatting.py -input_json rlhf_split -output_json rlhf_full_prompted -list_size 16493 -first_prompt "$first_prompt" -assistant_prompt "$assistant_prompt"
python3 response gpt.py -input_json rlhf_full_prompted -resume -max_threads 100 -temperature 0.7 -model gpt-3.5-turbo
python3 trim_response.py -input_json rlhf_full_asked -trim_blanks -trim_assistant_prompt

## Phase III: Create dataset
python3 formatting.py -input_json rlhf_full_trimmed