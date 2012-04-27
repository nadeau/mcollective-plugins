module MCollective
  module Agent
    class Lvm<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For LVM Management",
                  :description => "Agent to query LVM commands via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "Apache License, Version 2.0",
                  :version     => "1.0",
                  :timeout     => 5

      action "vgdisplay" do
        f = open("|/sbin/vgdisplay --units g")

        f.readlines.each do |line|
          if line.match(/VG\s+Size/)
            reply[:total]	= line.match(/[\d.]+/).to_s
          elsif line.match(/Alloc\s+PE/)
            reply[:allocated]	= line.match(/ \/ [\d.]+/).to_s.match(/[\d.]+/).to_s
          elsif line.match(/Free\s+PE/)
            reply[:free]	= line.match(/ \/ [\d.]+/).to_s.match(/[\d.]+/).to_s
          end          
        end

        f.close
      end

      action "lvdisplay" do
        f = open("|/sbin/lvdisplay --units g")
        name = ''

        f.readlines.each do |line|
          if line.match(/LV Name/)
            name	= line.match(/[^\/]+$/).to_s.chomp
          elsif line.match(/LV\s+Size/)
            reply[ name.to_sym ] = line.match(/[\d.]+/).to_s
          end          
        end

        f.close
      end

    end
  end
end
