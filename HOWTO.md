# How to add a Custom Model to FreeGPT for Testing

In this guide, you'll learn how to add a custom model to FreeGPT for testing purposes. FreeGPT is a versatile tool for running Language Large Language Models (LLMs), and by following these steps, you can expand its capabilities with your own models. Please note that only GGML that work with llama-cpp-python are supported in FreeGPT.

## Testing a Model

- Visit [Hugging Face](https://huggingface.co/) and navigate to the Models section.
- In the "Filter by name" field, enter the name of the model you want to test, followed by "ggml" (e.g., "orca ggml").
- Click on the model you want to use, such as "TheBloke/orca_mini_3B-GGML."

## Choosing the Model File

- In the model's page, go to the "Files and versions" tab.
- Select the smallest available `.bin` file version (e.g., `1.93GB orca-mini-3b.ggmlv3.q4_0.bin`).
- Right-click on the download arrow and copy the download link.

## Downloading the Model

- Open your terminal and SSH into your Start9 server where you have FreeGPT installed and running.
- Enter the FreeGPT container by executing: `sudo podman exec -it freegpt.embassy bash` and navigate to the 'weights' directory using the `cd weights` command.
- Download the model using `curl -OL` followed by the copied download link. For example:
   ```bash
   curl -OL https://huggingface.co/TheBloke/orca_mini_3B-GGML/resolve/main/orca-mini-3b.ggmlv3.q4_0.bin
   ```
- Once the model is successfully downloaded, it should appear in the FreeGPT models settings page and is ready to be tested.

## Adding Model to the Testing List

- After confirming that the model works with FreeGPT and produces satisfactory results, you can proceed to prepare your custom JSON entry.
- The entry should look like this:

```json
{
   "name": "Orca Mini 3B",
   "models": [
       {
           "name": "Orca-Mini-3B",
           "repo": "TheBloke/orca_mini_3B-GGML",
           "files": [
               {
                   "name": "q4",
                   "filename": "orca-mini-3b.ggmlv3.q4_0.bin",
                   "disk_space": 1930000000.0
               }
           ]
       }
   ]
}
```

Pay special attention to the `"repo"` and `"filename"` fields. Any mistake in these two fields can prevent the model from downloading.

## Making a Pull Request (PR)

- Finally, make a Pull Request (PR) for the `models-testing.json` file in the `weights` branch of the FreeGPT-startos GitHub repository: [FreeGPT-startos](https://github.com/Start9Labs/FreeGPT-startos/blob/weights/models-testing.json). Include the custom model entry you want to add.

Thank you for contributing to the FreeGPT community! Your efforts in adding new models help the community expand its capabilities and provide more options to users. If you discover other GGML models that work well with FreeGPT, don't hesitate to reach out and share your findings with the community. Together, we can make FreeGPT even more powerful and versatile.

