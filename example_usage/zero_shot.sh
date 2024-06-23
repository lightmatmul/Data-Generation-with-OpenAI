#!/bin/bash

## Parent directory
cd ..

first_prompt=$(cat <<'EOF'

## SYSTEM INSTRUCTION:
You are a dataset generator. You will be given context for what kind of data you want to generate. Your goal is to generate the dataset with the goal of it being used within a fine-tune.\n 

## USER INSTRUCTION:
Generate 3 random ideas about neuroscience.
EOF
)

assistant_prompt=$(cat <<'EOF'
EOF
)

## Generate muliple answers out of a single prompt
py prompt_format.py -output_json neuroscience_ideas_prompted -list_size 5 -first_prompt "$first_prompt" -assistant_prompt "$assistant_prompt" 
py response_gpt.py -input_json neuroscience_ideas_prompted -num_responses 5 -max_threads 5 -temperature 0.7 -model gpt-3.5-turbo 
py trim_response.py -input_json neuroscience_ideas_asked -trim_blanks -trim_assistant_prompt
