# frozen_string_literal: true

require_relative "rag_eval/version"

module RagEval
  class Error < StandardError; end

  # Main entry point for our DSL
  def self.evaluate(evaluation_name, &block)
    evaluator = Evaluator.new(evaluation_name)
    evaluator.instance_eval(&block)
    evaluator.run
  end

  # Class responsible for processing evaluation rules
  class Evaluator
    def initialize(name)
      @name = name
      @rules = []
    end

    # Keyword 'rule' to define a new evaluation rule
    def rule(description, &block)
      @rules << { description: description, block: block }
    end

    # Execute all rules defined by the user
    def run
      puts "\n[STARTED] Running Evaluation: #{@name}"
      puts "-" * 40

      @rules.each do |r|
        # Execute the block associated with the rule
        result = r[:block].call 
        
        # Print the formatted result
        status = result ? "[PASSED]" : "[FAILED]"
        puts "#{status} | #{r[:description]}"
      end
      
      puts "-" * 40
    end
  end
end