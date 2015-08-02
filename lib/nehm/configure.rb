# Configure module responds to 'nehm configure' command
module Configure
  def self.menu
    loop do
      puts 'Download path: ' + Paint[PathControl.dl_path, :magenta] if PathControl.dl_path
      puts 'iTunes path: ' + Paint[PathControl.itunes_path_name, :magenta] if PathControl.itunes_path
      puts 'Permalink: ' + Paint[Config[:permalink], :cyan] if Config[:permalink]
      puts "\n"

      HighLine.new.choose do |menu|
        menu.prompt = Paint['Choose setting', :yellow]

        menu.choice('Edit download path'.freeze) { PathControl.set_dl_path }
        menu.choice('Edit itunes path'.freeze) { PathControl.set_itunes_path } unless OS.linux?
        menu.choice('Edit permalink'.freeze) { UserControl.log_in }
        menu.choice('Exit'.freeze) { exit }
      end
      sleep(1)
      puts "\n"
    end
  end
end
