import json

def _write_dict_to_json(data: dict, filename: str):
    with open(filename, "w") as file:
        json.dump(data, file, indent=4)


def def_word_cnt(text: str) -> dict[str, int]:
    """Counts the occurrences of each word in the given text."""
    clean_text = "".join(
        char.lower() if char.isalnum() or char.isspace() else " " for char in text
    )

    words = clean_text.split()
    word_count: dict[str, int] = {}
    for word in words:
        if word in word_count:
            word_count[word] += 1
        else:
            word_count[word] = 1

    return word_count


input = """
hello world hello
data engineering is awesome
"""

# ---------- Write results to file ----------
_write_dict_to_json(def_word_cnt(input), "./result.json")


# ---------- Generate 100 result file ----------
def generate_100_files(text: str):
    word_count_result = def_word_cnt(text)

    list(
        map(
            lambda i: _write_dict_to_json(
                word_count_result, f"./results_1/result_{i}.json"
            ),
            range(1, 101),
        )
    )

generate_100_files(input)
