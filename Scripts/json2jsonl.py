import json
import argparse

def json_to_jsonl(json_filepath, jsonl_filepath):
    with open(json_filepath, 'r') as json_f, open(jsonl_filepath, 'w') as jsonl_f:
        json_list = json.load(json_f)

        for entry in json_list:
            json.dump(entry, jsonl_f)
            jsonl_f.write('\n')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert JSON to JSONL.')
    parser.add_argument('json_file', help='The JSON file to convert.')
    parser.add_argument('jsonl_file', help='The output JSONL file.')

    args = parser.parse_args()

    json_to_jsonl(args.json_file, args.jsonl_file)
