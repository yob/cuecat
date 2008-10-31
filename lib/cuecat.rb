require 'base64'
require 'ean13'

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

  def initialize(str)
    @number = str.to_s

    #if @number.size == 50
      swap
      split_components 
    #end
  end

  private

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

  def bitwise_op(value)
    arr = value.unpack("C*").collect { |c| c ^ 67 }
    arr.pack("C*")
  end
end
