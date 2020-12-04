class Image < ActiveRecord::Base

  def self.sip_logo
    sip = <<-sip

    ░██████╗████████╗░█████╗░████████╗░██████╗  
    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██╔════╝  
    ╚█████╗░░░░██║░░░███████║░░░██║░░░╚█████╗░  
    ░╚═══██╗░░░██║░░░██╔══██║░░░██║░░░░╚═══██╗  
    ██████╔╝░░░██║░░░██║░░██║░░░██║░░░██████╔╝  
    ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░  
    sip
    sip1 = <<-sip1

    ██╗███╗░░██╗  ████████╗██╗░░██╗███████╗  
    ██║████╗░██║  ╚══██╔══╝██║░░██║██╔════╝  
    ██║██╔██╗██║  ░░░██║░░░███████║█████╗░░  
    ██║██║╚████║  ░░░██║░░░██╔══██║██╔══╝░░  
    ██║██║░╚███║  ░░░██║░░░██║░░██║███████╗  
    ╚═╝╚═╝░░╚══╝  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝  
    sip1
    sip2 = <<-sip2

    ██████╗░░█████╗░██╗███╗░░██╗████████╗
    ██╔══██╗██╔══██╗██║████╗░██║╚══██╔══╝
    ██████╔╝███████║██║██╔██╗██║░░░██║░░░
    ██╔═══╝░██╔══██║██║██║╚████║░░░██║░░░
    ██║░░░░░██║░░██║██║██║░╚███║░░░██║░░░
    ╚═╝░░░░░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░░░╚═╝░░░
    sip2
    puts sip.colorize(:color => :light_red, :background => :blue)
    puts sip1.colorize(:color => :light_white, :background => :blue)
    puts sip2.colorize(:color => :light_red, :background => :blue)
    puts "\n"
  end

end
