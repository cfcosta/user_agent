require File.dirname(__FILE__) + '/spec_helper.rb'

describe UserAgent do

  describe '#browser' do
    it "should identify browser name and version (if available)" do
      examples = {
        "Firefox 0.9.3"     => "Mozilla/5.0 (Windows; U; Win98; de-DE; rv:1.7) Gecko/20040803 Firefox/0.9.3",
        "Firefox 1.5.0.3"   => "Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.8.0.3) Gecko/20060426 Firefox/1.5.0.3",
        "Firefox 2.0.0.18"  => "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.8.1.18) Gecko/20081029 Firefox/2.0.0.18",
        "Firefox 3.0b5"     => "Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9b5) Gecko/2008032620 Firefox/3.0b5",
        "Firefox 3.1.6"     => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.2) Gecko/2008092313 Ubuntu/8.04 (hardy) Firefox/3.1.6",
        "MSIE 5.5"          => "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
        "MSIE 7.0"          => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618)",
        "MSIE 8.0"          => "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)",
        "Opera 8.0"         => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 8.0",
        "Opera 9.02"        => "Opera/9.02 (Windows NT 5.1; U; pt-br)",
        "Opera 9.50"        => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 6.0; en) Opera 9.50",
        "Opera 9.52"        => "Opera/9.52 (Windows NT 6.0; U; Opera/9.52 (X11; Linux x86_64; U); en)",
        "Opera 9.61"        => "Mozilla/5.0 (Windows NT 5.1; U; en-GB; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.61",
        "Opera 9.62"        => "Opera/9.62 (X11; Linux i686; U; en) Presto/2.1.1",
        "Safari 3.1"        => "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_2; en-gb) AppleWebKit/526+ (KHTML, like Gecko) Version/3.1 iPhone",
        "Safari 3.2"        => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; sv-se) AppleWebKit/525.26.2 (KHTML, like Gecko) Version/3.2 Safari/525.26.12",
        "Safari"            => "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; fr) AppleWebKit/412.7 (KHTML, like Gecko) Safari/412.5",
        "Safari"            => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092816 Mobile Safari 1.1.3",
        "Safari"            => "Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_1 like Mac OS X; fr-fr) AppleWebKit/525.18.1 (KHTML, like Gecko) Mobile/5F136",
        "Chrome 5.0.342.9"  => "Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2",
        "Chrome 0.2.149.27" => "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.27 Safari/525.13",
        "" => ""
      }
      examples.keys.sort.each do |expected|
        agent = examples[expected]
        UserAgent.new(agent).browser.should == expected
      end
    end
  end
  
  describe '#os' do
    it "should identify os name and version (if available)" do
      examples = {
        "Linux"           => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.2) Gecko/2008092313 Ubuntu/8.04 (hardy) Firefox/3.1.6",
        "Linux"           => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092816 Mobile Safari 1.1.3",
        "Linux"           => "Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2",
        "Mac OS X 10.5.2" => "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_2; en-gb) AppleWebKit/526+ (KHTML, like Gecko) Version/3.1 iPhone",
        "Mac OS X 10.5.5" => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; sv-se) AppleWebKit/525.26.2 (KHTML, like Gecko) Version/3.2 Safari/525.26.12",
        "Mac OS X"        => "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; fr) AppleWebKit/412.7 (KHTML, like Gecko) Safari/412.5",
        "OpenBSD"         => "Mozilla/5.0 (X11; U; OpenBSD i386; en-US; rv:1.8.1.7) Gecko/20070930 Firefox/2.0.0.7",
        "Windows 2000"    => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; en) Opera 8.0",
        "Windows 98"      => "Mozilla/5.0 (Windows; U; Win98; de-DE; rv:1.7) Gecko/20040803 Firefox/0.9.3",
        "Windows ME"      => "Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.8.0.3) Gecko/20060426 Firefox/1.5.0.3",
        "Windows Vista"   => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618)",
        "Windows Vista"   => "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)",
        "Windows Vista"   => "Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9b5) Gecko/2008032620 Firefox/3.0b5",
        "Windows XP"      => "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
        "Windows XP"      => "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.8.1.18) Gecko/20081029 Firefox/2.0.0.18",
        "iPhone"          => "Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_1 like Mac OS X; fr-fr) AppleWebKit/525.18.1 (KHTML, like Gecko) Mobile/5F136",
        "" => ""
      }
      examples.keys.sort.each do |expected|
        agent = examples[expected]
        UserAgent.new(agent).os.should == expected
      end
    end
  end
  
  describe '#mobile' do
    it "should identify when it is a mobile device" do
      computers_examples = [
        "Mozilla/5.0 (Windows; U; Win98; de-DE; rv:1.7) Gecko/20040803 Firefox/0.9.3",
        "Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.8.0.3) Gecko/20060426 Firefox/1.5.0.3",
        "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.8.1.18) Gecko/20081029 Firefox/2.0.0.18",
        "Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9b5) Gecko/2008032620 Firefox/3.0b5",
        "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.2) Gecko/2008092313 Ubuntu/8.04 (hardy) Firefox/3.1.6",
        "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
        "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618)",
        "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)",
        "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 8.0",
        "Opera/9.02 (Windows NT 5.1; U; pt-br)",
        "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 6.0; en) Opera 9.50",
        "Opera/9.52 (Windows NT 6.0; U; Opera/9.52 (X11; Linux x86_64; U); en)",
        "Mozilla/5.0 (Windows NT 5.1; U; en-GB; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.61",
        "Opera/9.62 (X11; Linux i686; U; en) Presto/2.1.1",
        "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; sv-se) AppleWebKit/525.26.2 (KHTML, like Gecko) Version/3.2 Safari/525.26.12",
        "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; fr) AppleWebKit/412.7 (KHTML, like Gecko) Safari/412.5",
        "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.2) Gecko/2008092313 Ubuntu/8.04 (hardy) Firefox/3.1.6",
        "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; sv-se) AppleWebKit/525.26.2 (KHTML, like Gecko) Version/3.2 Safari/525.26.12",
        "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; fr) AppleWebKit/412.7 (KHTML, like Gecko) Safari/412.5",
        "Mozilla/5.0 (X11; U; OpenBSD i386; en-US; rv:1.8.1.7) Gecko/20070930 Firefox/2.0.0.7",
        "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; en) Opera 8.0",
        "Mozilla/5.0 (Windows; U; Win98; de-DE; rv:1.7) Gecko/20040803 Firefox/0.9.3",
        "Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.8.0.3) Gecko/20060426 Firefox/1.5.0.3",
        "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618)",
        "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)",
        "Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9b5) Gecko/2008032620 Firefox/3.0b5",
        "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
        "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.8.1.18) Gecko/20081029 Firefox/2.0.0.18"
      ]
      mobiles_examples = [
        "Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_1 like Mac OS X; fr-fr) AppleWebKit/525.18.1 (KHTML, like Gecko) Mobile/5F136",
        "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_2; en-gb) AppleWebKit/526+ (KHTML, like Gecko) Version/3.1 iPhone",
        "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092816 Mobile Safari 1.1.3",
        "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/1A542a Safari/419.3",
        "Mozilla/5.0 (iPod; U; CPU iPhone OS 3_1_1 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Mobile/7C145",
        "Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B367 Safari/531.21.10",
        "SIE-S68/36 UP.Browser/7.1.0.e.18 (GUI) MMP/2.0 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SIE-EF81/58 UP.Browser/7.0.0.1.181 (GUI) MMP/2.0 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "BlackBerry7100i/4.1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/103",
        "BlackBerry7130e/4.1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/104",
        "BlackBerry7250/4.0.0 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "BlackBerry7230/3.7.0",
        "BlackBerry7520/4.0.0 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "BlackBerry7730/3.7.0",
        "Mozilla/4.0 BlackBerry8100/4.2.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/100",
        "BlackBerry8130/4.3.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/109",
        "BlackBerry8310/4.2.2 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/121",
        "BlackBerry8320/4.3.1 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "BlackBerry8700/4.1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/100",
        "BlackBerry8703e/4.1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/105",
        "BlackBerry8820/4.2.2 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102",
        "BlackBerry8830/4.2.2 Profile/MIDP-2.0 Configuration/CLOC-1.1 VendorID/105",
        "BlackBerry9000/4.6.0.65 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102",
        "BlackBerry9530/4.7.0.167 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102 UP.Link/6.3.1.20.0",
        "BlackBerry9530/5.0.0.328 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/105",
        "BlackBerry 9630 Tour BlackBerry9630/4.7.1.40 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/104",
        "BlackBerry9700/5.0.0.423 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/100",
        "Mozilla/5.0 (Linux; U; Android 1.5; de-; sdk Build/CUPCAKE) AppleWebkit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1",
        "Mozilla/5.0 (Linux; U; Android 2.1-update1; en-US; Nexus One Build/ERE27) AppleWebkit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17",
        "HTC-8500/1.2 Mozilla/4.0 (compatible; MSIE 5.5; Windows CE; PPC; 240x320)",
        "HTC-8500/1.2 Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.6) UP.Link/6.3.1.17.0",
        "HTC_P3650 Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.6)",
        "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) PPC; 240x320; HTC P3450; OpVer 23.116.1.611",
        "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.6) SP; 240x320; HTC_S710/1.0 ...",
        "Mozilla/5.0 (Linux; U; Android 1.5; en-za; HTC Hero Build/CUPCAKE) AppleWebKit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1",
        "Mozilla/5.0 (Linux; U; Android 1.6; en-us; HTC_TATTOO_A3288 Build/DRC79) AppleWebKit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1",
        "LG/U880/v1.0",
        "LG-B2050 MIC/WAP2.0 MIDP-2.0/CLDC-1.0",
        "LG-C1100 MIC/WAP2.0 MIDP-2.0/CLDC-1.0",
        "LGE-CU8080/1.0 UP.Browser/4.1.26l",
        "LG-G1800 MIC/WAP2.0 MIDP-2.0/CLDC-1.0",
        "LG-G210/SW100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G220/V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G232/V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G262/V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G5200 AU/4.10",
        "LG-G5600 MIC/WAP2.0 MIDP-2.0/CLDC-1.0",
        "LG-G610 V100 AU/4.10 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G622/V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G650 V100 AU/4.10 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G660/V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G672/V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G682 /V100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G688 MIC/V100/WAP2.0 MIDP-2.0/CLDC-1.0",
        "LG-G7000 AU/4.10",
        "LG-G7050 UP.Browser/6.2.2 (GUI) MMP/1.0 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G7100 AU/4.10 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G7200 UP.Browser/6.2.2 (GUI) MMP/1.0 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G822/SW100/WAP2.0 Profile/MIDP-2.0 Configuration/CLDC-1.0",
        "LG-G850 V100 UP.Browser/6.2.2 (GUI) MMP/1.0 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G920/V122/WAP2.0 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG-G922 Obigo/WAP2.0 MIDP-2.0/CLDC-1.1",
        "LG-G932 UP.Browser/6.2.3(GUI)MMP/1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "LG-KP500 Teleca/WAP2.0 MIDP-2.0/CLDC-1.1",
        "LG-KS360 Teleca/WAP2.0 MIDP-2.0/CLDC-1.1",
        "LG-L1100 UP.Browser/6.2.2 (GUI) MMP/1.0 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LGE-MX8700/1.0 UP.Browser/6.2.3.2 (GUI) MMP/2.0",
        "LG-T5100 UP.Browser/6.2.3 (GUI) MMP/1.0 Profile/MIDP-1.0 Configuration/CLDC-1.0",
        "LG/U8120/v1.0",
        "LG/U8130/v1.0",
        "LG/U8138/v2.0",
        "LG/U8180/v1.0",
        "LGE-VX9100/1.0 UP.Browser/6.2.3.2 (GUI) MMP/2.0",
        "MOT-V3r/08.BD.43R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "MOT-K1/08.03.08R MIB/BER2.2 Profile/MIDP-2.0 Configuration/CLDC-1.1 EGE/1.0",
        "MOT-L6/0A.52.2BR MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "MOT-MOTORAZRV9/4 BER2.2 Mozilla/4.0 (compatible; MSIE 6.0; 14003181) Profile/MIDP-2.0 Configuration/CLDC-1.1 Op! era 8.00 [en] UP.Link/6.3.0.0.0",
        "MOT-RAZRV3xx/96.64.21P BER2.2 Mozilla/4.0 (compatible; MSIE 6.0; 11003002) Profile/MIDP-2.0 Configuration/CLDC-1.1 Opera 8.00 [en] UP.Link/6.3.0.0.0",
        "MOT-MOTORAZRV9x/9E.03.15R BER2.2 Mozilla/4.0 (compatible; MSIE 6.0; 13003337) Profile/MIDP-2.0 Configuration/CLDC-1.1 Opera 8.60 [en] UP.Link/6.3.0.0.0",
        "MOT-MOTOZ9/9E.01.03R BER2.2 Mozilla/4.0 (compatible; MSIE 6.0; 11003002) Profile/MIDP-2.0 Configuration/CLDC-1.1 Opera 8.60 [en] UP.Link/6.3.0.0.0",
        "Mozilla/5.0 (Linux; U; Android 2.0.1; en-us; Droid Build/ESD56) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17",
        "Nokia2610/2.0 (07.04a) Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Link/6.3.1.20.0",
        "Nokia5300/2.0 (05.51) Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "Mozilla/5.0 (SymbianOS/9.3; U; Series60/3.2 Nokia5630d-1/012.020; Profile MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413",
        "Nokia6030/2.0 (y3.44) Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "Nokia6230i/2.0 (03.40) Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "Nokia6280/2.0 (03.60) Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "Nokia6650d-1bh/ATT.2.15 Mozilla/5.0 (SymbianOS/9.3; U; [en]; Series60/3.2; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413",
        "Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 NokiaE51-1/220.34.37; Profile/MIDP-2.0 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413",
        "NokiaE71x/ATT.03.11.1 Mozilla/5.0 SymbianOS/9.3; U; [en]; Series60/3.2; Profile/MIDP-2.1 Configuration/CLDC-1.1 AppleWebKit/413 KHTML, like Gecko) Safari/413 UP.Link/6.3.0.0.0",
        "NokiaN70-1/5.0616.2.0.3 Series60/2.8 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "NokiaN75-3/3.0 (1.0635.0.0.6); SymbianOS/9.1 Series60/3.0 Profile/MIDP-2.0 Configuration/CLDC-1.1) UP.Link/6.3.0.0",
        "NokiaN80-1/3.0(4.0632.0.10) Series60/3.0 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "NokiaN90-1/5.0607.7.3 Series60/2.8 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 NokiaN95/11.0.026; Profile MIDP-2.0 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413",
        "Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-3/21.2.045; Profile/MIDP-2.1 Configuration/CLDC-1.1;) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.4",
        "Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; PalmSource/hspr-H102; Blazer/4.0) 16;320x320",
        "Mozilla/5.0 (webOS/1.4.0; U; en-US) AppleWebKit/532.2 (KHTML, like Gecko) Version/1.0 Safari/532.2 Pre/1.0",
        "Mozilla/5.0 (webOS/Palm webOS 1.2.9; U; en-US) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/1.0 Safari/525.27.1 Pixi/1.0",
        "SAMSUNG-SGH-A737/UCGI3 SHP/VPP/R5 NetFront/3.4 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1 UP.Link/6.3.1.17.0",
        "SAMSUNG-SGH-A737/1.0 SHP/VPP/R5 NetFront/3.3 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1 UP.Link/6.3.0.0.0",
        "SAMSUNG-SGH-A767/A767UCHG2 SHP/VPP/R5 NetFront/3.4 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1 UP.Link/6.3.0.0.0",
        "SAMSUNG-SGH-A867/A867UCHG5 SHP/VPP/R5 NetFront/3.4 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1 UP.Link/6.3.0.0.0",
        "SAMSUNG-SGH-A877/A877UCHK1 SHP/VPP/R5 NetFront/3.5 SMM-MMS/1.2.0 profile/MIDP-2.1 configuration/CLDC-1.1 UP.Link/6.3.0.0.0",
        "SAMSUNG-SGH-D600/1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) MMP/2.0",
        "SAMSUNG-SGH-Z720/1.0 SHP/VPR/R5 NetFront/3.3 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1",
        "SAMSUNG-SGH-E250/1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) MMP/2.0",
        "SEC-SGHU600/1.0 NetFront/3.2 Profile",
        "SAMSUNG-SGH-U900-Vodafone/U900BUHD6 SHP/VPP/R5 NetFront/3.4 Qtv5.3 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1",
        "SAMSUNG-SGH-T919/919UVHL3SHP/VPP/R5NetFront/3.5SMM-MMS/1.2.0profile/MIDP-2.1configuration/CLDC-1.1",
        "SAMSUNG-SGH-i900/1.0 Opera 9.5",
        "SAMSUNG-SGH-i907/UCHI5 Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.11)",
        "SAMSUNG-SGH-I617/1.0 Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) UP.Link/6.3.0.0.0",
        "Mozilla/5.0 (Linux; U; Android 1.5; de-de; Galaxy Build/CUPCAKE) AppleWebkit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1",
        "SonyEricssonK510i/R4CJ Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonK550i/R8BA Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonK610i/R1CB Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonK630i/R1CA Browser/NetFront/3.4 Profile/MIDP-2.1 Configuration/CLDC-1.1",
        "SonyEricssonK700/R1A Profile/MIDP-1.0 MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonK750i/R1CA Browser/SEMC-Browser/4.2 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonK800i/R8BF Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonW800i/R1AA Browser/SEMC-Browser/4.2 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonW810i/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonW900i/R5AH Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "SonyEricssonW995/R1DB Browser/NetFront/3.4 Profile/MIDP-2.1 Configuration/CLDC-1.1 JavaPlatform/JP-8.4.1",
        "SonyEricssonZ500a/R1A SEMC-Browser/4.0.1 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Link/6.3.1.20.0",
        "SonyEricssonC901/R1EA Browser/NetFront/3.4 Profile/MIDP-2.1 Configuration/CLDC-1.1 JavaPlatform/JP-8.4.2"
      ]
      computers_examples.each do |agent|
        user_agent = UserAgent.new(agent)
        user_agent.is_mobile?.should == false
        user_agent.is_bot?.should    == false
      end
      mobiles_examples.each do |agent|
        user_agent = UserAgent.new(agent)
        user_agent.is_mobile?.should == true
        user_agent.is_bot?.should    == false
      end
    end
  end
  
  it "should detect bot user agents" do
    bots = [
      "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Googlebot/2.1 (+http://www.googlebot.com/bot.html)",
      "msnbot/1.0 (+http://search.msn.com/msnbot.htm)",
      "msnbot/0.11 (+http://search.msn.com/msnbot.htm)",
      "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)",
      "Mozilla/2.0 (compatible; Ask Jeeves/Teoma)",
      "Mozilla/5.0 (compatible; ScoutJet; +http://www.scoutjet.com/)",
      "curl/7.9.x (win32) libcurl 7.9.x"
    ]
    bots.each do |bot|
      user_agent = UserAgent.new(bot)
      user_agent.is_bot?.should == true
    end
  end


  it "should handle commentless user agents" do
    UserAgent.new("asdf").browser.should == 'asdf'
  end
  
  it "should gracefully handle nil values" do
    UserAgent.new(nil).browser.should == ''
  end

end
