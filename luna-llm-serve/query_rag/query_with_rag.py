import os
import sys
import time

import pickle
import boto3

from typing import Union
from botocore.exceptions import NoCredentialsError, ClientError

from openai import OpenAI
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS

# Fetch RAG context for question, form prompt with context and question and 
# then call LLM
def get_answer(question: Union[str, None]):
    """
    Get the answer to the provided question by interacting with the Vector DB and LLM
    """

    # retrieve docs relevant to the input question
    docs = retriever.invoke(input=question)
    print ("Number of relevant documents used as context for query: ", len(docs))

    # concatenate relevant docs to be used as context 
    allcontext = ""
    for i in range(len(docs)):
        allcontext += docs[i].page_content 
    
    promptstr = template.format(context=allcontext, question=question)
    
    # send query to the LLM
    completions = client.chat.completions.create(
        model="mosaicml/mpt-7b-chat",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {
                "role": "user",
                "content": promptstr,
            },
        ],
        # explain default
        max_tokens=200,

        # explain default
        temperature=0.01,

        # explain default
        stream=True,
    )

    print("Answer:\n")
    for chat in completions:
       if chat.choices[0].delta.content is not None:
          print(chat.choices[0].delta.content, end="")
    print("")


if __name__ == "__main__":

    # Setup model and query template parameters
    model = "mosaicml--mpt-7b-chat"
    template = """Answer the question based only on the following context:
    {context}

    Question: {question}
    """
    os.environ["TOKENIZERS_PARALLELISM"] = "false"

    # Get connection to LLM server
    model_llm_server_url = os.environ.get('MODEL_LLM_SERVER_URL')
    if model_llm_server_url is None:
        print("Please set environment variable MODEL_LLM_SERVER_URL")
        sys.exit(1)
    llm_server_url = model_llm_server_url + "/v1"

    # Create a client to talk via the OpenAI API to hosted LLM
    client = OpenAI(
        base_url=llm_server_url,
        api_key="NOT A REAL KEY",
    )

    # Retrieve env vars needed to access Vector DB
    vectordb_bucket = os.environ.get('VECTOR_DB_S3_BUCKET')
    print ("Using vector DB s3 bucket: ", vectordb_bucket)
    if vectordb_bucket is None:
        print("Please set environment variable VECTOR_DB_S3_BUCKET")
        sys.exit(1)

    vectordb_key = os.environ.get('VECTOR_DB_S3_FILE')
    print ("Using vector DB s3 file containing vector store: ", vectordb_key)
    if vectordb_key is None:
        print("Please set environment variable VECTOR_DB_S3_FILE")
        sys.exit(1)
    print ("Loading Vector DB...")

    # Load vectorstore and get retriever for it
    s3_client = boto3.client('s3')
    response = None
    try:
        response = s3_client.get_object(Bucket=vectordb_bucket, Key=vectordb_key)
    except ClientError as e:
        print(f"Error accessing object, {vectordb_key} in bucket, {vectordb_bucket}, err: {e}")
        sys.exit(1)

    body = response['Body'].read()

    # needs prereq package sentence_transformers and faiss-cpu
    vectorstore = pickle.loads(body)

    retriever = vectorstore.as_retriever()
    print("Created Vector DB retriever successfully. \n")

    # get question from user and print answer
    question = input('Type your query here: ') 
    get_answer(question)
