# frozen_string_literal: true
# encoding: UTF-8
#--
# This file is automatically generated. Do not modify it.
# Generated by: oedipus_lex version 2.5.2.
# Source: lib/rubocop/ast/node_pattern/lexer.rex
#++

# The only difficulty is to distinguish: `fn(argument)` from `fn (sequence)`.
# The presence of the whitespace determines if it is an _argument_ to the
# function call `fn` or if a _sequence_ follows the function call.
#
# If there is the potential for an argument list, the lexer enters the state `:ARG`.
# The rest of the times, the state is `nil`.
#
# In case of an argument list, :tARG_LIST is emitted instead of a '('.
# Therefore, the token '(' always signals the beginning of a sequence.


##
# The generated lexer RuboCop::AST::NodePattern::LexerRex

class RuboCop::AST::NodePattern::LexerRex
  require 'strscan'

  # :stopdoc:
  CONST_NAME  = /[A-Z:][a-zA-Z_:]+/
  SYMBOL_NAME = /[\w+@*\/?!<>=~|%^-]+|\[\]=?/
  IDENTIFIER  = /[a-z][a-zA-Z0-9_]*/
  NODE_TYPE   = /[a-z][a-zA-Z0-9_-]*/
  CALL        = /(?:#{CONST_NAME}\.)?#{IDENTIFIER}[!?]?/
  REGEXP_BODY = /(?:[^\/]|\\\/)*/
  REGEXP      = /\/(#{REGEXP_BODY})(?<!\\)\/([imxo]*)/
  # :startdoc:
  # :stopdoc:
  class LexerError < StandardError ; end
  class ScanError < LexerError ; end
  # :startdoc:

  ##
  # The file name / path

  attr_accessor :filename

  ##
  # The StringScanner for this lexer.

  attr_accessor :ss

  ##
  # The current lexical state.

  attr_accessor :state

  alias :match :ss

  ##
  # The match groups for the current scan.

  def matches
    m = (1..9).map { |i| ss[i] }
    m.pop until m[-1] or m.empty?
    m
  end

  ##
  # Yields on the current action.

  def action
    yield
  end


  ##
  # The current scanner class. Must be overridden in subclasses.

  def scanner_class
    StringScanner
  end unless instance_methods(false).map(&:to_s).include?("scanner_class")

  ##
  # Parse the given string.

  def parse str
    self.ss     = scanner_class.new str
    self.state  ||= nil

    do_parse
  end

  ##
  # Read in and parse the file at +path+.

  def parse_file path
    self.filename = path
    open path do |f|
      parse f.read
    end
  end

  ##
  # The current location in the parse.

  def location
    [
      (filename || "<input>"),
    ].compact.join(":")
  end

  ##
  # Lex the next token.

  def next_token

    token = nil

    until ss.eos? or token do
      token =
        case state
        when nil then
          case
          when ss.skip(/\s+/) then
            # do nothing
          when ss.skip(/:(#{SYMBOL_NAME})/o) then
            action { emit :tSYMBOL, &:to_sym }
          when ss.skip(/"(.+?)"/) then
            action { emit :tSTRING }
          when ss.skip(/[-+]?\d+\.\d+/) then
            action { emit :tNUMBER, &:to_f }
          when ss.skip(/[-+]?\d+/) then
            action { emit :tNUMBER, &:to_i }
          when ss.skip(/#{Regexp.union(
                    %w"( ) { | } [ ] < > $ ! ^ ` ... + * ? ,"
                  )}/o) then
            action { emit ss.matched, &:to_sym }
          when ss.skip(/#{REGEXP}/o) then
            action { emit_regexp }
          when ss.skip(/%?(#{CONST_NAME})/o) then
            action { emit :tPARAM_CONST }
          when ss.skip(/%([a-z_]+)/) then
            action { emit :tPARAM_NAMED }
          when ss.skip(/%(\d*)/) then
            action { emit(:tPARAM_NUMBER) { |s| s.empty? ? 1 : s.to_i } } # Map `%` to `%1`
          when ss.skip(/_(#{IDENTIFIER})/o) then
            action { emit :tUNIFY }
          when ss.skip(/_/o) then
            action { emit :tWILDCARD }
          when ss.skip(/\#(#{CALL})/o) then
            action { @state = :ARG; emit :tFUNCTION_CALL, &:to_sym }
          when ss.skip(/#{IDENTIFIER}\?/o) then
            action { @state = :ARG; emit :tPREDICATE, &:to_sym }
          when ss.skip(/#{NODE_TYPE}/o) then
            action { emit :tNODE_TYPE, &:to_sym }
          when ss.skip(/\#.*/) then
            action { emit_comment }
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}) at #{location}: '#{text}'"
          end
        when :ARG then
          case
          when ss.skip(/\(/) then
            action { @state = nil; emit :tARG_LIST }
          when ss.skip(//) then
            action { @state = nil }
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}) at #{location}: '#{text}'"
          end
        else
          raise ScanError, "undefined state at #{location}: '#{state}'"
        end # token = case state

      next unless token # allow functions to trigger redo w/ nil
    end # while

    raise LexerError, "bad lexical result at #{location}: #{token.inspect}" unless
      token.nil? || (Array === token && token.size >= 2)

    # auto-switch state
    self.state = token.last if token && token.first == :state

    token
  end # def next_token
end # class
