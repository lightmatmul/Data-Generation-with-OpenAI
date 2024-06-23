#!/bin/bash

## Parent directory
cd ..

## Phase I: Generate coding questions
py prompt_formatting.py -output_json coding_questions_prompted -list_size 5 \
    -first_prompt "Please generate a numbered list of {list_size} simple coding questions that span a variety of topics." \
    -assistant_prompt "1. " 
py response_gpt.py -input_json coding_questions_prompted -max_threads 5 -temperature 0.7 -model gpt-3.5-turbo 
py trim_response.py -input_json coding_questions_asked -trim_blanks -trim_assistant_prompt
py split_response.py -input_json coding_questions_trimmed -new_key "question"

## Phase II: Generate GPT answers for the coding questions
first_prompt=$(cat <<'EOF'

## SYSTEM INSTRUCTION:
You are an AI assistant. User will you give you a task. Your goal is to complete the task as faithfully as you can. While performing the task think step-by-step and justify your steps.

## USER INSTRUCTION:
Here is a coding question: '{question}'. How would you solve it? Describe the process in step by step reasoning.
EOF
)

assistant_prompt=$(cat <<'EOF'
EOF
)
py prompt_formatting.py -input_json coding_questions_split -output_json coding_answers_prompted -list_size 10 -first_prompt "$first_prompt" -assistant_prompt "$assistant_prompt"
py response_gpt.py -input_json coding_answers_prompted -max_threads 5 -temperature 0 -model gpt-3.5-turbo 
py trim_response.py -input_json coding_answers_asked -trim_blanks -trim_assistant_prompt

## Phase III: Create datasets
py alpaca_formatting.py -input_json coding_answers_trimmed 
