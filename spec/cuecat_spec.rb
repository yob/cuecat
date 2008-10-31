$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

require 'spec'
require 'cuecat'

describe "The CueCat class" do

  it "should correctly translate a cuecat code to its component parts" do
    code = CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG.")
    code.code_type.should eql("IBN")
    code.id.should eql("000000005112157601")
    code.value.should eql("9781843549161")

    code = CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7C3T1E3DZDxPWCW.")
    code.code_type.should eql("IBN")
    code.id.should eql("000000005112157601")
    code.value.should eql("9780868406930")

    code = CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGf2.ENr7C3j3C3f7Dxr7DxzYDNnZ.")
    code.code_type.should eql("IB5")
    code.id.should eql("000000005112157601")
    code.value.should eql("978014028678651500")
  end

end
