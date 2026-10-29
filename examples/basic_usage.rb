# frozen_string_literal: true

require_relative "../lib/rag_eval"

# Simulating a response from a local LLM or RAG pipeline
mock_llm_response = "The ChromaDB vector store is running on localhost."

RagEval.evaluate("RAG Output Quality Check") do
  
  rule("Response should not be empty") do
    !mock_llm_response.empty?
  end

  rule("Response must contain the database name") do
    mock_llm_response.include?("ChromaDB")
  end

  rule("Response must mention Python") do
    # This rule is designed to fail intentionally to see the output
    mock_llm_response.include?("Python")
  end

end