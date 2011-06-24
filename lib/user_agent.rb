class UserAgent
  VERSION = '0.0.1'
  
  attr_reader :browser_name, :browser_version
  attr_reader :os_name, :os_version
  
  def initialize(user_agent)
    @user_agent = user_agent
    return if @user_agent.nil?
    extract_products_from_agent_string
    return if @products.empty?

    identify_browser
    identify_os
  end
  
  def browser
    [browser_name, browser_version].compact.join(' ')
  end
  
  def os
    [os_name, os_version].compact.join(' ')
  end

  def to_s
    @user_agent
  end
  
  def is_mobile?
    # see http://detectmobilebrowser.com
    pattern1 = /android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile|o2|opera m(ob|in)i|palm( os)?|p(ixi|re)\/|plucker|pocket|psp|smartphone|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce; (iemobile|ppc)|xiino/i

    pattern2 = /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i

    return false if @user_agent.to_s.empty?

    if pattern1 =~ @user_agent or pattern2 =~ @user_agent[0,4]
      return true
    else
      return false
    end
  end

  def is_bot?
    return true if @user_agent.to_s.empty?

    # list of possible bot user_agents
    pattern1 = /google|bot|yahoo|spider|archiver|curl|python|nambu|twitt|perl|sphere|PEAR|java|wordpress|radian|crawl|yandex|eventbox|monitor|mechanize|facebookexternal|teoma|scoutjet/i

    if pattern1 =~ @user_agent
      # caso o user_agent for de um mobile não consideramos ele como bot, por existir diversos browsers em java,etc
      if self.is_mobile?
        return false
      else
        return true
      end
    else
      return false
    end
  end

private
  def extract_products_from_agent_string
    pattern = Regexp.new(
      "([^/\s]*)" +                           # product token
      "(/([^\s]*))?" +                        # optional version
      "([\s]*\\[[a-zA-Z][a-zA-Z]\\])?" +      # optional old netscape
      "[\s]*" +                               # eat space!
      "(\\((([^()]|(\\([^()]*\\)))*)\\))?" +  # optional comment, allow one deep nested ()
      "[\s]*"                                 # eat space!
    )
    @products = @user_agent.scan(pattern).map{|match|
      [match[0], match[2], match[5]]
    }.select{|product| !product[0].empty?}
  end
  
  # Browser Identification
  
  def identify_browser
    identify_browser_opera or
    identify_browser_safari or
    identify_browser_honest or
    identify_browser_compatible or
    identify_browser_mozilla or
    identify_browser_other
  end
  
  def identify_browser_opera
    return unless @user_agent =~ /Opera/
    
    if opera = @products.detect{|product| product[0] == 'Opera'}
      if opera[1].nil?
        if @products[-2][0] == 'Opera'
          @browser_version = @products[-1][0]
        end
      else
        @browser_version = opera[1]
      end
      @browser_name = "Opera"
    end
  end
  
  def identify_browser_safari
    return unless @user_agent =~ /Safari|iPhone/
    
    # Google Chrome uses the WebKit rendering engine, which is shared by other browsers such as Apple's Safari 
    # see more: http://www.google.com/chrome/intl/en/webmasters-faq.html#useragent
    if browser = @products.detect{|product| product[0] == 'Chrome'}
      @browser_version = browser[1]
      @browser_name = 'Chrome'
    else
      if version = @products.detect{|product| product[0] == 'Version'}
        @browser_version = version[1]
      elsif browser = @products.detect{|product| product[0] == 'Safari'}
        @browser_version = browser[1]
      end
      @browser_name = 'Safari'
    end
  end
  
  def identify_browser_honest
    honest_browsers = %w(Firefox Netscape Camino Mosaic Galeon)
    if browser = @products.detect{|product| honest_browsers.include? product[0]}
      @browser_version = browser[1]
      @browser_name = browser[0]
    end
  end
  
  def identify_browser_compatible
    compatible = /^compatible; ([^\s]+) ([^\s;]+)/
    if browser = @products.detect{|product| product[0] == 'Mozilla' && product[2] =~ compatible}
      # TODO? check_for_cloaked_products(AVANT_BROWSER, CRAZY_BROWSER);
      @browser_version = $2
      @browser_name = $1
    end
  end
  
  def identify_browser_mozilla
    first = @products.first
    if first[0] == 'Mozilla'
      if first[1].to_f < 5.0
        @browser_version = first[1]
        @browser_name = 'Netscape'
      else
        first[2] =~ /rv:([^s]+)/
        @browser_version = $1
        @browser_name = first[0]
      end
    end
  end
  
  def identify_browser_other
    @browser_version = @products.first[1]
    @browser_name = @products.first[0]
  end
  
  # OS Identification
  
  def identify_os
    @comment_elements = @products[0][2].split(/\s*;\s*/) rescue []
    identify_os_windows or
    identify_os_mac or
    identify_os_linux or
    identify_os_other
  end
  
  def identify_os_windows
    return unless element = @comment_elements.detect{|e| e =~ /^win.*\d/i}
    @os_name = 'Windows'
    @os_version = case element
    when /98/
      '98'
    when /9x 4.90/
      'ME'
    when /NT 4.0/
      'NT'
    when /NT 5.0/
      '2000'
    when /NT 5.1/
      'XP'
    when /NT 6.0/
      'Vista'
    end
  end
  
  def identify_os_mac
    return unless element = @comment_elements.detect{|e| e =~ /Mac OS X/} or
                  element = @comment_elements.detect{|e| e =~ /Macintosh/}
    @os_name = case element
    when /iphone/i
      'iPhone'
    else
      'Mac OS X'
    end
    
    if element =~ /(10_._.)/
      @os_version = $1.gsub('_','.')
    end
  end
  
  def identify_os_linux
    return unless element = @comment_elements.detect{|e| e =~ /linux/i}
    @os_name = 'Linux'
  end
  
  def identify_os_other
    %w(FreeBSD NetBSD OpenBSD SunOS Amiga BeOS IRIX OS/2 Warp).each do |os|
      os_regexp = Regexp.new(Regexp.escape(os))
      if @comment_elements.detect{|e| e =~ os_regexp}
        @os_name = os
        return
      end
    end
  end
end
