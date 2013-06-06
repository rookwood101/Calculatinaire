###
Oversees tokenising (splitting byway regex) of expression strings
###
class CALCULATINAIRE.Encoder.Tokeniser


	###
	Configures the tokeniser

	@param [Object] input_variables Contains the string input and array of token regex matchers
		@option [String] input The string to be tokenised
		@option [Array] tokenMatchers The array of regex matches for tokens
	###
	configure: (input_variables)->
		@input_string = input_variables.input or throw new Error 'CALCULATINAIRE.Encoder.Tokeniser.configure: No string input configured.'
		@input_token_matchers = input_variables.tokenMatchers or throw new Error 'CALCULATINAIRE.Encoder.Tokeniser.configure: No token matchers configured.'

	###
	Perform tokenisation

	@returns [Array] The string, fully tokenised
	###
	tokenise: ()->
		if @input_string? and @input_token_matchers?
			return @input_string.match(generateRegEx(@input_token_matchers))
		else 
			throw new Error 'CALCULATINAIRE.Encoder.Tokeniser.tokenise: Tokeniser instance not configured.'


	###
	Generate the regular expression to match the tokens

	@param [Array] matchers All matchers to be formed into the regex
	@returns [RegExp] A regex for all of the matchers inputted
	###
	generateRegEx: (matchers)->
		regexOutput = ""
		for matchToken in matchers
			regexOutput += "(" + matchToken + ")|"
		return new RegExp(regexOutput.substring(0, regexOutput.length - 2), "ig")