require 'base64'
require 'ean13'
require 'upc'

# An extra simple class for decoding a cuecat code into
# its components.
#
#    code = CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG.")
#    puts code.code_type
#    puts code.id
#    puts code.value
#
# This code is based on the PHP version I found here:
#   http://www.phpbuilder.com/snippet/download.php?type=snippet&id=699
# Thanks Adam!
#
class CueCat

  attr_reader :code_type, :id, :value

  class Version #:nodoc:
    Major = 1
    Minor = 0
    Tiny  = 0

    String = [Major, Minor, Tiny].join('.')
  end

  class << self
    # A very basic check to see if the supplied code looks like a cuecat code.
    # At this stage I'm not aware of any fullproof way to check.
    #
    def valid?(code)
      code = code.to_s
      if code[0,1] != "."
        false
      elsif code[-1,1] != "."
        false
      elsif code.scan(/\./).size != 4
        false
      else
        true
      end
    end

    def ean?(code)
      self.new(code).ean?
    end

    def upc?(code)
      self.new(code).upc?
    end
  end

  # process a new cuecat code
  #
  def initialize(str)
    @number = str.to_s

    if valid?
      swap
      split_components
    end
  end

  # is the supplied code valid?
  def valid?
    CueCat.valid? @number
  end

  def ean?
    return false if @value.nil?
    EAN13.valid?(@value)
  end

  def upc?
    return false if @value.nil?
    UPC.valid?(@value)
  end

  private

  # Swap letters with their upper or lower case equivilants.
  #
  # Go go gadget hardcore encryption.
  #
  def swap
    arr = @number.unpack("C*").collect do |c|
      if c > 64 && c < 91
        c + 32
      elsif c > 96 && c < 123
        c - 32
      else
        c
      end
    end
    @number.replace arr.pack("C*")
  end

  # Split the code by the full stops, and base64 decode each part.
  #
  # If the code is an EAN, calculate its check digit
  #
  def split_components
    @number.gsub!("-","/")
    something, id, code_type, value = *@number.split(".")
    @id        = bitwise_op(Base64.decode64(id))
    @code_type = bitwise_op(Base64.decode64(code_type))
    @value     = bitwise_op(Base64.decode64(value))

    if @code_type == "IBN" && @value.size == 12
      @value = EAN13.complete(@value)
    end
  end

  # bitwise XOR each value with 67. The final step to enlightenment.
  #
  def bitwise_op(value)
    arr = value.unpack("C*").collect { |c| c ^ 67 }
    arr.pack("C*")
  end
end
