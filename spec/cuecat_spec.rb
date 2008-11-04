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

  it "should correctly detect valid codes" do
    # EAN
    CueCat.valid?(".C3nZC3nZC3n2CNjXCNz0DxnY.cGf2.ENr7C3j3C3f7Dxr7DxzYDNnZ.").should be_true
    CueCat.valid?(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7C3T1E3DZDxPWCW.").should be_true
    CueCat.valid?(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG.").should be_true

    CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG.").valid?.should be_true

    # UPC
    CueCat.valid?(".C3nZC3nZC3n2CNjXCNz0DxnY.fHmc.DxbXDhb0Dhf7ChbY.").should be_true
  end

  it "should correctly detect invalid codes" do
    CueCat.valid?(nil).should be_false
    CueCat.valid?(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG").should be_false
    CueCat.valid?(1).should be_false
    CueCat.valid?([0,1,2]).should be_false
  end

  it "should correctly detect EAN13 codes" do
    CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG.").ean?.should be_true
    CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.cGf2.ENr7C3j3C3f7Dxr7DxzYDNnZ.").ean?.should be_false

    CueCat.ean?(".C3nZC3nZC3n2CNjXCNz0DxnY.cGen.ENr7CNT3Chz3ENj1CG.").should be_true
  end

  it "should correctly detect UPC12 codes" do
    CueCat.new(".C3nZC3nZC3n2CNjXCNz0DxnY.fHmc.DxbXDhb0Dhf7ChbY.").upc?.should be_true

    CueCat.upc?(".C3nZC3nZC3n2CNjXCNz0DxnY.fHmc.DxbXDhb0Dhf7ChbY.").should be_true
  end

end
