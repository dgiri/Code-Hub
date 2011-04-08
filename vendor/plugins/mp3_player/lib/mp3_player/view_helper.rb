module Mp3Player
  # This module contains the view helper <tt>mp3_player</tt> and <tt>google_mp3_player</tt>
  module ViewHelper
    # This counter is used to generated unique IDs
    @@player_count = 0

    # This is the helper method you'll call in the view. <tt><%= mp3_player @song.mp3.url %></tt>
    # See the options at http://wpaudioplayer.com/standalone for more info on customising the player to match your site
    def mp3_player path, options = {}
      increment_player_count

      options.merge!({soundFile: path})

      %Q[
        <p id="audioplayer_#{@@player_count}">Alternative content</p>
          <script type="text/javascript">
            AudioPlayer.embed("audioplayer_#{@@player_count}", #{options.to_json});
          </script>
      ].html_safe
    end
  
    def google_mp3_player path
      %Q[
        <embed type="application/x-shockwave-flash" wmode="transparent" src="http://www.google.com/reader/ui/3523697345-audio-player.swf?audioUrl=#{path}" height="27" width="320"></embed>
      ].html_safe
    end

    def increment_player_count
      @@player_count += 1
    end

    def self.reset_player_count
      @@player_count = 0
    end
  end
end