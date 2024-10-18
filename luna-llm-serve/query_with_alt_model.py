from openai import OpenAI
import os
import random

query = input("Type your query here: ")
modelid = os.getenv("MODEL_ID", "mosaicml/mpt-7b-chat")
altmodelid = os.getenv("ALT_MODEL_ID", "microsoft/Phi-3-mini-4k-instruct")

# Note: Ray Serve doesn't support all OpenAI client arguments and may ignore some.
client1 = OpenAI(
    # Replace the URL if deploying your app remotely
    # (e.g., on Anyscale or KubeRay).
    base_url="http://localhost:8000/v1",
    api_key="NOT A REAL KEY",
)
# Always call first model
chat_completion = client1.chat.completions.create(
    model=modelid,
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {
            "role": "user",
            "content": query,
        },
    ],
    temperature=0.01,
    stream=True,
)
modelused = modelid

# Call second model 10% of the time.  Simulating a behavior where 10% of the time,
# a FrugalGPT evaluator decided the first model response wasn't good enough.
random.seed()
randval = random.random()
if randval < 0.10:
    client2 = OpenAI(
        # Replace the URL if deploying your app remotely
        # (e.g., on Anyscale or KubeRay).
        base_url="http://localhost:8001/v1",
        api_key="NOT A REAL KEY",
    )
    chat_completion = client2.chat.completions.create(
        model=altmodelid,
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {
                "role": "user",
                "content": query,
            },
        ],
        temperature=0.01,
        stream=True,
    )
    modelused = altmodelid

# Print response results
txt = f"(from {modelused}) "
print(txt)
for chat in chat_completion:
    if chat.choices[0].delta.content is not None:
        print(chat.choices[0].delta.content, end="")
print("")
