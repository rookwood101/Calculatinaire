###
Oversees encoding of string expression into binary expression tree
###
class CALCULATINAIRE.Encoder.Encoder


	###
	Configure the Encoder instance with terms supported by the calculator

	@param [Object] terms_supported Contains all terms and their types supported by the calculator
		@option terms_supported [Array] operator_binary
		@option terms_supported [Array] operator_unary
		@option terms_supported [Array] operator_other
		@option terms_supported [Class] operand_number
		@option terms_supported [Array] operand_other
	###
	configure: (terms_supported)->
		@terms_supported.operator_binary = terms_supported.operator_binary or []
		@terms_supported.operator_unary = terms_supported.operator_unary or []
		@terms_supported.operator_other = terms_supported.operator_other or []
		if @terms_supported.operator_binary is [] and @terms_supported.operator_unary is [] and @terms_supported.operator_other is []
			throw new Error 'CALCULATINAIRE.Encoder.Encoder.configure: At least one operator must be configured.'

		@terms_supported.operand_number = terms_supported.operand_number or throw new Error 'CALCULATINAIRE.Encoder.Encoder.configure: The number type must be configured.'
		@terms_supported.operand_other = terms_supported.operand_other or []


	###
	Commence encoding - converts input into binary expression tree

	@param [String] input_string Contains the string you want to be converted
	@return [Expression_Tree] A binary expression tree

	@todo Write type_converter encode method
	@todo Write expression_tree_generator encode method
	###
	encode: (input_string)->

		ts = @terms_supported
		if not ts.operator_binary? or not ts.operator_unary? or not ts.operator_other? or not ts.operand_number? or not ts.operand_other?
			throw new Error 'CALCULATINAIRE.Encoder.Encoder.encode: Encoder must be configured before encoding can commence.'

		tokeniser = new CALCULATINAIRE.Encoder.Tokeniser()
		generated_token_matchers = @generateTokenMatchers()
		tokeniser.configure(
			tokenMatchers: generated_token_matchers
			input: input_string
		)
		tokeniser.tokenise

		type_converter = new CALCULATINAIRE.Encoder.Type_Converter()

		expression_tree_generator = new CALCULATINAIRE.Encoder.Expression_Tree_Generator()
	

	###
	Generate token matchers for the tokeniser

	@note Should this go in the tokeniser class?
	###
	generateTokenMatchers: ()->
		ts = @terms_supported
		tokenMatchers = []

		for op_bin in ts.operator_binary
			tokenMatchers.push(op_bin.toString())
		for op_un in ts.operator_unary
			tokenMatchers.push(op_un.toString())
		for op_oth in ts.operator_other
			tokenMatchers.push(op_oth.toString())

		tokenMatchers.push(ts.operand_number.regex_matcher)
		for opand_oth in ts.operand_other
			tokenMatchers.push(opand_oth.regex_matcher)

		return tokenMatchers