# FreeGPT Language Models (Weights Branch)

This branch is dedicated to storing language models lists for FreeGPT.

## Available Models

### models-small.json

> Use this JSON file if your machine has up to 8GB of RAM.
```
https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-small.json
```

### models-big.json

> This JSON file is recommended for use with more powerful machines, with more than 16GB of RAM.

```
https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-big.json
```

## Adding Models

To contribute or add new models to this repository, please make sure they are in the GGML format. You can then submit a pull request to the weights branch.

**Format**: Ensure that your model information is formatted as follows:

```json
{
    "name": "Luna AI Llama2 Uncensored",
    "models": [
        {
            "name": "Luna-AI-Llama2-Uncensored-GGML",
            "repo": "TheBloke/Luna-AI-Llama2-Uncensored-GGML",
            "files": [
                {
                    "name": "q2_K",
                    "filename": "luna-ai-llama2-uncensored.ggmlv3.q2_K.bin",
                    "disk_space": 2860000000.0
                }
            ]
        }
    ]
}
```

   - `"name"`: Specify the model's name.
   - `"models"`: List of model details, you can have multiple models under one entry.
   - `"name"`: Name of the specific model visible in Model choice.
   - `"repo"`: Hugging Face repository where the model files are hosted.
   - `"files"`: List of files for the model, you can have multiple files.
   - `"name"`: Name for models quant method.
   - `"filename"`: Actual filename of the model file hosted on Hugging Face.
   - `"disk_space"`: Size of the model file in bytes.

For more detailed instructions on how to add a custom model for testing, check out our comprehensive guide: [Add a Custom Model to FreeGPT for Testing](./HOWTO.md).

We appreciate your contributions!
