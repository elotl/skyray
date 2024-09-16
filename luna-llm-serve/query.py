from openai import OpenAI

query = input("Enter a query, e.g., What are some highly rated restaurants in San Francisco?: ")

# Note: Ray Serve doesn't support all OpenAI client arguments and may ignore some.
client = OpenAI(
    # Replace the URL if deploying your app remotely
    # (e.g., on Anyscale or KubeRay).
    base_url="http://localhost:8000/v1",
    api_key="NOT A REAL KEY",
)
chat_completion = client.chat.completions.create(
    model="mosaicml/mpt-7b-chat",
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

for chat in chat_completion:
    if chat.choices[0].delta.content is not None:
        print(chat.choices[0].delta.content, end="")
print("")
