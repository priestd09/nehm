module AppleScript
  def self.add_track_to_playlist(track_path, playlist_name)
    `osascript #{script_path(:add_track_to_playlist)} #{track_path} #{playlist_name} > /dev/null`
  end

  def self.list_of_playlists
    output = `osascript #{script_path(:list_of_playlists)}`
    output.chomp.split(', ')
  end

  module_function

  def script_path(script_name)
    applescripts_path = File.expand_path('applescripts', __dir__)
    File.join(applescripts_path, "#{script_name.to_s}.applescript")
  end
end